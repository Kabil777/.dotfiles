require("nvim-treesitter.configs").setup({
	ensure_installed = { "c", "lua", "java", "javascript", "html", "tsx", "jq", "yaml" },
	auto_install = true,

	highlight = {
		enable = true, -- Enable syntax highlighting
	},
	indent = { enable = true },
})

vim.cmd("doautocmd ColorScheme")
