local mason_lspconfig = require("mason-lspconfig")
local nvim_lsp = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

mason_lspconfig.setup({
	ensure_installed = { "lua_ls", "ts_ls", "pyright" } -- Adjust to your desired servers
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
mason_lspconfig.setup_handlers({
	function(server_name)
		nvim_lsp[server_name].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})
	end,
})
