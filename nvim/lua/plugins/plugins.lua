return { --ui-plugins
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
					require("telescope.builtin").find_files({
						cwd = require("lazy.core.config").options.root,
					})
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
		"simrat39/symbols-outline.nvim",
		"nvim-tree/nvim-web-devicons",
	},

	--language_server_plugin
	{
		"neovim/nvim-lspconfig",
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
			local lspconfig = require("lspconfig")

			lspconfig.yamlls.setup({
				settings = {
					yaml = {
						schemas = {
							kubernetes = "*.k8s.yaml",
							["https://raw.githubusercontent.com/quantumblacklabs/kedro/develop/static/jsonschema/kedro-catalog-0.17.json"] = "conf/**/*catalog*",
							["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
							["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
							["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
							["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
							["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
							["http://json.schemastore.org/ansible-playbook"] = "*play*.{yml,yaml}",
							["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
							["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
							["https://json.schemastore.org/gitlab-ci"] = "*gitlab-ci*.{yml,yaml}",
							["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*api*.{yml,yaml}",
							["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
							["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] = "*flow*.{yml,yaml}",
						},
						validate = true,
						format = { enable = true },
						hover = true,
						completion = true,
					},
				},
			})
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
	},
	{
		"karb94/neoscroll.nvim",
		config = function()
			require("neoscroll").setup({})
		end,
	},
	{ "nvzone/showkeys", cmd = "ShowkeysToggle" },
	{
		"nvim-java/nvim-java",
		dependencies = {
			"nvim-java/lua-async-await",
			"nvim-java/nvim-java-core",
			"nvim-java/nvim-java-test",
			"nvim-java/nvim-java-refactor",
			"nvim-java/nvim-java-dap",
			"mfussenegger/nvim-jdtls",
		},
		require("java").setup({}),
	},
	{
		"elmcgill/springboot-nvim",
		depedencies = {
			"neovim/nvim-lspconfig",
			"mfussenegger/nvim-jdtls",
		},
		config = function()
			local springboot_nvim = require("springboot-nvim")
			vim.keymap.set("n", "<leader>Jr", springboot_nvim.boot_run, { desc = "Spring Boot Run Project" })
			vim.keymap.set("n", "<leader>Jc", springboot_nvim.generate_class, { desc = "Java Create Class" })
			vim.keymap.set("n", "<leader>Ji", springboot_nvim.generate_interface, { desc = "Java Create Interface" })
			vim.keymap.set("n", "<leader>Je", springboot_nvim.generate_enum, { desc = "Java Create Enum" })
			springboot_nvim.setup({})
		end,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			views = {
				cmdline_popup = {
					border = {
						style = "single",
						padding = { 1, 3 },
					},
					position = {
						row = "40%",
						col = "50%",
					},
					filter_options = {},
					win_options = {
						winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
					},
				},
			},
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},

	{
		"nvim-telescope/telescope-ui-select.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
	},
	{
		"towolf/vim-helm",
		ft = "helm",
	},
	{
		"kevinhwang91/nvim-ufo",
		dependencies = {
			"kevinhwang91/promise-async",
		},
		event = "BufReadPost",
	},
}
