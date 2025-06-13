local telescope = require("telescope")

local opts = {
	defaults = {
		layout_config = {
			horizontal = {
				preview_cutoff = 0, -- Ensures the preview is always shown
				preview_height = 0.5, -- Set the preview to take up 50% of the window height
				prompt_position = "top", -- Moves the prompt to the top
			},
		},
		layout_strategy = "horizontal", -- Choose "horizontal" layout to support top preview positioning
	},
}
telescope.load_extension("live_grep_args")
telescope.setup(opts)
