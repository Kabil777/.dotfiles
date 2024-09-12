return {
	"nvim-treesitter/nvim-treesitter",
	"nvim-treesitter/playground",
	build = ":TSUpdate",
	configs = function()
		local configs = require("nvim-treesitter.configs")
		configs.setup({
			ensure_installed = { "c", "lua", "java", "javascript", "html", "tsx", "jq", "yaml" },
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			context_commentstring = {
				enable = true,
			},
			indent = { enable = true },
		})
	end,
	{
		"maxmellon/vim-jsx-pretty",
	},
}
