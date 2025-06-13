return {
	--ui-plugins
	"nvim-lua/plenary.nvim",
	{
		"nvchad/ui",
		config = function()
			require("nvchad")
		end,
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
		dependencies = {
			{
				"nvim-telescope/telescope-live-grep-args.nvim",
				version = "^1.0.0",
			},
		},
		keys = {
			{ "<leader>/",  false },
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
		"L3MON4D3/LuaSnip",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
	},

	--language_server_plugin
	{
		"neovim/nvim-lspconfig",
		"williamboman/mason.nvim",
		opts = {
			inlay_hints = { enabled = false },
			registries = {
				"github:nvim-java/mason-registry",
				"github:mason-org/mason-registry",
			},
		},
	},
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
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
	{
		"nvzone/showkeys",
		cmd = "ShowkeysToggle",
	},

	{
		"nvim-java/nvim-java",
		dependencies = {
			"nvim-java/lua-async-await",
			{
				"nvim-java/nvim-java-core",
				url = "https://github.com/Kabil777/nvim-java-core.git",
				branch = "fix/mason-api-update",
			},
			"nvim-java/nvim-java-test",
			"nvim-java/nvim-java-refactor",
			"nvim-java/nvim-java-dap",
			"mfussenegger/nvim-jdtls",
		},
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
			vim.keymap.set("n", "<leader>Ji", springboot_nvim.generate_interface,
				{ desc = "Java Create Interface" })
			vim.keymap.set("n", "<leader>Je", springboot_nvim.generate_enum, { desc = "Java Create Enum" })
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		build = "make install_jsregexp"
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {},
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
			lsp = {
				signature = {
					enabled = false,
				},
			},
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
	{
		-- UFO folding
		{
			"kevinhwang91/nvim-ufo",
			dependencies = {
				"kevinhwang91/promise-async",
				{
					"luukvbaal/statuscol.nvim",
					config = function()
						local builtin = require("statuscol.builtin")
						require("statuscol").setup({
							relculright = true,
							segments = {
								{ text = { builtin.foldfunc },       click = "v:lua.ScFa" },
								{ text = { "%s" },                   click = "v:lua.ScSa" },
								{ text = { builtin.lnumfunc, "  " }, click = "v:lua.ScLa" },
							},
						})
					end,
				},
			},
			event = "BufReadPost",
			opts = {
				provider_selector = function()
					return { "treesitter", "indent" }
				end,
			},

			init = function()
				vim.keymap.set("n", "zR", function()
					require("ufo").openAllFolds()
				end)
				vim.keymap.set("n", "zM", function()
					require("ufo").closeAllFolds()
				end)
			end,
		},
		{ "anuvyklack/fold-preview.nvim", dependencies = "anuvyklack/keymap-amend.nvim", config = true },
	},
	{
		"nosduco/remote-sshfs.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		opts = {
			-- Refer to the configuration section below
			-- or leave empty for defaults
		},
	},
	{ "wintermute-cell/gitignore.nvim", dependencies = "nvim-telescope/telescope.nvim" },

	{
		"Bekaboo/dropbar.nvim",
		-- optional, but required for fuzzy finder support
		dependencies = {
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
		config = function()
			local dropbar_api = require("dropbar.api")
			vim.keymap.set("n", "<Leader>;", dropbar_api.pick, { desc = "Pick symbols in winbar" })
			vim.keymap.set("n", "[;", dropbar_api.goto_context_start,
				{ desc = "Go to start of current context" })
			vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Select next context" })
		end,
	},
	{
		"stevearc/aerial.nvim",
		opts = {},
		-- Optional dependencies
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
	},
	{
		"javiorfo/nvim-springtime",
		lazy = false,
		cmd = { "Springtime", "SpringtimeUpdate" },
		dependencies = {
			"javiorfo/nvim-popcorn",
			"javiorfo/nvim-spinetta",
			"hrsh7th/nvim-cmp",
		},
		build = function()
			require("springtime.core").update()
		end,
		opts = {

			-- Springtime popup section
			spring = {
				-- Project: Gradle, Gradle Kotlin and Maven (Gradle default)
				project = {
					selected = 1,
				},
				-- Language: Java, Kotlin and Groovy (Java default)
				language = {
					selected = 1,
				},
				-- Packaging: Jar and War (Jar default)
				packaging = {
					selected = 1,
				},
				project_metadata = {
					group = "com.meteorz",
					artifact = "meteorz",
					name = "meteorz",
					package_name = "com.meteorz",
					version = "0.0.1-SNAPSHOT",
				},
			},
			-- Some popup options
			dialog = {
				selection_keymap = "<C-Space>",
				generate_keymap = "<C-CR>",
				confirmation = true,
				style = {
					title_link = "Boolean",
					section_link = "Type",
				},
			},
			-- Workspace is where the generated Spring project will be saved
			workspace = {
				path = vim.fn.expand("%:p:h"),
				decompress = true,
				open_auto = true,
			},

			internal = {
				log_debug = false,
			},
		},
	},
	{
		"ibhagwan/fzf-lua",
		-- optional for icon support
		dependencies = { "nvim-tree/nvim-web-devicons" },
		-- or if using mini.icons/mini.nvim
		-- dependencies = { "echasnovski/mini.icons" },
		opts = {},
	},
	{
		"someone-stole-my-name/yaml-companion.nvim",
		requires = {
			{ "neovim/nvim-lspconfig" },
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope.nvim" },
		},
		config = function()
			require("telescope").load_extension("yaml_schema")
		end,
	},
	{
		"sindrets/diffview.nvim",
		config = function()
			require("diffview").setup({})
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({})
		end,
	},
	{
		"isakbm/gitgraph.nvim",
		opts = {
			symbols = {
				merge_commit = "M",
				commit = "*",
			},
			format = {
				timestamp = "%H:%M:%S %d-%m-%Y",
				fields = { "hash", "timestamp", "author", "branch_name", "tag" },
			},
			hooks = {
				on_select_commit = function(commit)
					print("selected commit:", commit.hash)
				end,
				on_select_range_commit = function(from, to)
					print("selected range:", from.hash, to.hash)
				end,
			},
		},
		keys = {
			{
				"<leader>gl",
				function()
					require("gitgraph").draw({}, { all = true, max_count = 5000 })
				end,
				desc = "GitGraph - Draw",
			},
		},
	},
	{
		"kawre/leetcode.nvim",
		build = ":TSUpdate html", -- if you have `nvim-treesitter` installed
		dependencies = {
			"nvim-telescope/telescope.nvim",
			-- "ibhagwan/fzf-lua",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
		},
		opts = {
			-- configuration goes here
		},
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		config = function()
			require("mason-nvim-dap").setup({
				ensure_installed = { "java-debug-adapter", "java-test" },
			})
		end,
	},
	{ "mistricky/codesnap.nvim",        build = "make",                                "axieax/urlview.nvim" },
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		"aserowy/tmux.nvim",
		config = function()
			return require("tmux").setup()
		end,
	},
	{
		"saghen/blink.cmp",
		version = "*",
		event = { "LspAttach" },
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		opts = {
			keymap = {
				["<CR>"] = { "accept", "fallback" },
				["<TAB>"] = { "select_next", "fallback" },
				["<S-TAB>"] = { "select_prev", "fallback" },
			},
			sources = {
				default = { "lazydev", "lsp", "path", "snippets", "buffer" },
				providers = {
					cmdline = {
						min_keyword_length = 2,
					},
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100,
					},
				},
			},
			-- signature = {
			-- 	enabled = true,
			-- 	window = {
			-- 		border = "single",
			-- 	},
			-- },
			completion = {
				menu = {
					min_width = 25,
					max_height = 10,
					border = "single",
					scrolloff = 1,
					scrollbar = false,
					draw = {
						treesitter = { "lsp" },
					},
				},
				documentation = {
					auto_show_delay_ms = 0,
					auto_show = true,
					window = {
						border = "single",
						scrollbar = false,
					},
				},
				ghost_text = {
					enabled = false,
				},
			},
		},
	},
	-- {
	-- 	"lewis6991/hover.nvim",
	-- 	config = function()
	-- 		require("hover").setup({
	-- 			init = function()
	-- 				-- Require providers
	-- 				require("hover.providers.lsp")
	-- 				require("hover.providers.gh")
	-- 				-- require('hover.providers.gh_user')
	-- 				require("hover.providers.jira")
	-- 				-- require('hover.providers.dap')
	-- 				require("hover.providers.fold_preview")
	-- 				-- require('hover.providers.diagnostic')
	-- 				require("hover.providers.man")
	-- 				-- require('hover.providers.dictionary')
	-- 				-- require('hover.providers.highlight')
	-- 			end,
	-- 			preview_opts = {
	-- 				border = "single",
	-- 			},
	-- 			preview_window = false,
	-- 			title = true,
	-- 			mouse_providers = {
	-- 				"LSP",
	-- 			},
	-- 			mouse_delay = 1000,
	-- 		})
	--
	-- 		-- Setup keymaps
	-- 		vim.keymap.set("n", "K", require("hover").hover, { desc = "hover.nvim" })
	-- 		vim.keymap.set("n", "gK", require("hover").hover_select, { desc = "hover.nvim (select)" })
	-- 		vim.keymap.set("n", "<C-p>", function()
	-- 			require("hover").hover_switch("previous")
	-- 		end, { desc = "hover.nvim (previous source)" })
	-- 		vim.keymap.set("n", "<C-n>", function()
	-- 			require("hover").hover_switch("next")
	-- 		end, { desc = "hover.nvim (next source)" })
	--
	-- 		-- Mouse support
	-- 		vim.keymap.set("n", "<MouseMove>", require("hover").hover_mouse, { desc = "hover.nvim (mouse)" })
	-- 		vim.o.mousemoveevent = true
	-- 	end,
	-- },

	{
		"ray-x/lsp_signature.nvim",
		event = "InsertEnter",
		opts = {
			-- cfg options
		},
	}
}
