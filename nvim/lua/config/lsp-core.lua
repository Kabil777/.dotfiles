-- lua/lsp_config.lua

local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local nvim_lsp = require("lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")

-- Setup capabilities for nvim-cmp
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Configure Mason UI and automatic installation.
mason.setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
	automatic_installation = true,
})

-- Ensure the desired LSP servers are installed.
mason_lspconfig.setup({
	ensure_installed = { "lua_ls", "ts_ls", "pyright", "jdtls", "yamlls" },
})

-- Common on_attach function for all servers.
local on_attach = function(client, bufnr)
	if client.server_capabilities.documentFormattingProvider then
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = vim.api.nvim_create_augroup("LspFormat", { clear = true }),
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({ async = false })
			end,
		})
	end
end

-- Setup handlers for each server.
mason_lspconfig.setup_handlers({
	function(server_name)
		local opts = {
			capabilities = capabilities,
			on_attach = on_attach,
		}

		if server_name == "yamlls" then
			opts.settings = {
				yaml = {
					-- Disable the schema store so it doesn’t inject additional schemas.
					schemaStore = { enable = false },
					-- IMPORTANT: Map your custom Kubernetes schema to an array of file patterns.
					schemas = {
						Kubernetes = "*.yaml",
					},
					format = { enable = true },
				},
			}
		end

		nvim_lsp[server_name].setup(opts)
	end,
})
