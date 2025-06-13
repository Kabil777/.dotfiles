local mason = require("mason")
local opts = {
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
	automatic_installation = true,

	registries = {
		"github:nvim-java/mason-registry",
		"github:mason-org/mason-registry",
	},
}

mason.setup(opts)
