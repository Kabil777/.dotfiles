return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗"
					}
				},
				automatic_installation = true,
			})
		end
	},

	{
		"williamboman/mason-lspconfig.nvim",
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",  -- For LSP autocompletion
			"hrsh7th/cmp-buffer",    -- Buffer completions
			"hrsh7th/cmp-path",      -- Path completions
			"hrsh7th/cmp-cmdline",   -- Command-line completions
			"L3MON4D3/LuaSnip",      -- Snippet engine
			"saadparwaiz1/cmp_luasnip", -- Snippet completions
			"rafamadriz/friendly-snippets",
			"mlaursen/vim-react-snippets",
		},
		--nvim-cmp setup
		config = function()
			--using lunasnip for autocompletions,snippets,etc...
			local luasnip = require('luasnip')
			require("luasnip.loaders.from_vscode").lazy_load()
			require("vim-react-snippets").lazy_load()

			local cmp = require('cmp')
			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body) -- For expanding snippets
					end,
				},
				mapping = {
					['<C-b>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<C-Space>'] = cmp.mapping.complete(),
					['<C-e>'] = cmp.mapping.abort(),
					['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept selected item
					['<Tab>'] = cmp.mapping.select_next_item(),
					['<S-Tab>'] = cmp.mapping.select_prev_item(),
				},
				sources = cmp.config.sources({
					{ name = 'nvim_lsp' }, -- LSP source
					{ name = 'luasnip' }, -- Snippet source
				}, {
					{ name = 'buffer' }, -- Buffer source
					{ name = 'path' }, -- Path source
				})
			})
			-- LSP setup
			local nvim_lsp = require("lspconfig")
			local mason_lspconfig = require("mason-lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local on_attach = function(client, bufnr)
				-- Format on save
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
		end
	}
}
