local mason_lspconfig = require("mason-lspconfig")
local nvim_lsp = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

mason_lspconfig.setup({
	ensure_installed = { "lua_ls", "ts_ls", "pyright", "jdtls" }, -- Adjust to your desired servers
})

local on_attach = function(client, bufnr)
	if client.server_capabilities.documentFormattingProvider then
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = vim.api.nvim_create_augroup("Format", { clear = true }),
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format()
			end,
		})
	end
end

lspconfig.yamlls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		yaml = {
			schemas = {
				kubernetes = "*.yaml",
				["https://json.schemastore.org/github-workflow.json"] = ".github/workflows/*",
				["https://json.schemastore.org/github-action.json"] = ".github/action.{yml,yaml}",
				["https://json.schemastore.org/kustomization.json"] = "kustomization.{yml,yaml}",
				["https://json.schemastore.org/helm-chart.json"] = "Chart.{yml,yaml}",
			},
			format = { enable = true },
			validate = true,
			hover = true,
			completion = true, -- Ensure completion is enabled
		},
	},
})

mason_lspconfig.setup_handlers({
	function(server_name)
		nvim_lsp[server_name].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})
	end,
})
