return {
	--ui-plugins
	"nvim-lua/plenary.nvim",
	{
		"nvchad/ui",
		config = function()
			require("nvchad")
		end,
		cmp = {
			lspkind_text = true,
			style = "default",
			format_colors = {
				tailwind = true,
			},
		},
	},

	{
		"nvchad/volt",
		"nvchad/base46",
		lazy = false,
		build = function()
			require("base46").load_all_highlights()
		end,
	},
	--neo-tree

	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
	},
	--telescope Plugin
	{
		"nvim-telescope/telescope.nvim",
		keys = {
			{ "<leader>/", false },
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
			{
				"<leader>fp",
				function()
					require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
				end,
				desc = "Find Plugin File",
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		"nvim-treesitter/playground",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
	},

	--cmp_plugin
	{
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"rafamadriz/friendly-snippets",
	},

	--language_server_plugin
	{
		"neovim/nvim-lspconfig",
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" }, -- Ensure mason is loaded first
	},
	{
		"nvimtools/none-ls.nvim",
	},
	{
		"m4xshen/autoclose.nvim",
		"numToStr/Comment.nvim",
		"maxmellon/vim-jsx-pretty",
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("indent_blankline").setup({
				char = "│",
				show_trailing_blankline_indent = false,
				show_first_indent_level = true,
				use_treesitter = true,
				show_current_context = true,
				show_current_context_start = false,
			})
			vim.api.nvim_set_hl(0, "IndentBlanklineContextChar", { fg = "#C678DD", underline = false })
		end,
	},
	{
		"karb94/neoscroll.nvim",
		config = function()
			require("neoscroll").setup({})
		end,
	},
	{ "nvzone/showkeys", cmd = "ShowkeysToggle" },
}
