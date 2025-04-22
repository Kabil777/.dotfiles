vim.o.foldcolumn = "1" -- Show fold column (0 to disable)
vim.o.foldlevel = 99 -- Using ufo provider needs a large foldlevel
vim.o.foldlevelstart = 99
vim.o.foldenable = true

require("ufo").setup({
	provider_selector = function(bufnr, filetype, buftype)
		return { "lsp", "indent" }
	end,
})
