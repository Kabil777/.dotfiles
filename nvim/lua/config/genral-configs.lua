require("Comment").setup({
	toggler = {
		line = "gcc", -- Line-comment toggle
		block = "gbc", -- Block-comment toggle
	},
	opleader = {
		line = "gc",
		block = "gb",
	},
	extra = {
		eol = "gA", -- End-of-line comment toggle
	},
	mappings = {
		basic = true,
		extra = true,
	},
})

require("autoclose").setup()
require("showkeys").setup({
	cmd = "ShowkeysToggle",
})
