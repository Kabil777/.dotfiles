require("noice").setup({
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
				row = "40%", -- Center vertically
				col = "50%", -- Center horizontally
			},
			filter_options = {},
			win_options = {
				winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
			},
		},
	},
})
