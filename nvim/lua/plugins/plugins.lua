return {
	"nvim-lua/plenary.nvim",

	{
		"nvchad/ui",
		config = function()
			require "nvchad"
		end,
		cmp = {
			lspkind_text = true,
			style = "default",
			format_colors = {
				tailwind = false,
			},
		}
	},

	{
		"nvchad/base46",
		lazy = false,
		build = function()
			require("base46").load_all_highlights()
		end,
	},

	{
		"nvchad/volt",
	},

	{
		'nvim-tree/nvim-tree.lua',
		lazy = true,
		dependencies = {
			'nvim-tree/nvim-web-devicons',
		},
	},

	-- Completion plugin
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"L3MON4D3/LuaSnip",
	"saadparwaiz1/cmp_luasnip",
	"rafamadriz/friendly-snippets",

	-- LSP Config
	"neovim/nvim-lspconfig",
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" }, -- Ensure mason is loaded first
	},

	-- File Explorer
	{
		"nvim-tree/nvim-tree.lua",
		requires = "nvim-tree/nvim-web-devicons",
	}, {
	"nvimtools/none-ls.nvim",
}
}
