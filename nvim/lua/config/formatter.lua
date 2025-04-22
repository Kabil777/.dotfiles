local util = require("formatter.util")

return {
	filetype = {
		java = {
			function()
				return {
					exe = "google-java-format", -- make sure this is installed!
					args = { "-" },
					stdin = true,
				}
			end,
		},
		xml = {
			function()
				return {
					exe = "xmlformat",
					args = { "--indent", "2" },
					stdin = true,
				}
			end,
		},
	},
}
