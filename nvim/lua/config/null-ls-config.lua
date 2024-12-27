local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require("null-ls")

local opts = {
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.prettier.with({
			extra_args = { "--single-quote", "--jsx-single-quote" }, -- Customize Prettier options if needed
		}),

		null_ls.builtins.formatting.google_java_format,
		null_ls.builtins.diagnostics.mypy,
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.biome,
	},

	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({
				group = augroup,
				buffer = bufnr,
			})
		end
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({ bufnr = bufnr })
			end,
		})
	end,
}
null_ls.setup(opts)
