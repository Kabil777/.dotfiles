require("neo-tree").setup({
	window = {
		position = "right",
	},
	filesystem = {
		filtered_items = {
			visible = true, -- Show filtered (hidden) files
			hide_dotfiles = false, -- Show dotfiles like .env, .gitignore
			hide_gitignored = false, -- Show files ignored by git
		},
	},
})
