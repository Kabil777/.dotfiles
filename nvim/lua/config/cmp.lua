return {
	"saghen/blink.cmp",
	version = "*",
	event = { "LspAttach" },
	dependencies = {
		"rafamadriz/friendly-snippets",
	},
	opts = {
		keymap = {
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
				enabled = true,
			},
		},
	},
}
