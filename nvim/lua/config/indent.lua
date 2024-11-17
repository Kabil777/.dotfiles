local indent = require("ibl")
vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "tokyonight",
	callback = function()
		local colors = require("tokyonight.colors").setup()
		vim.api.nvim_set_hl(0, "IndentBlanklineContextChar", { fg = colors.fg })
	end,
})
local opts = {
	indent = {
		char = "┊",
	},
	scope = {
		enabled = true,
		show_start = false, -- Don't highlight just the start of the scope
		show_end = false, -- Don't highlight just the end of the scope
		highlight = IndentBlanklineContextChar,
	},
}
indent.setup(opts)
