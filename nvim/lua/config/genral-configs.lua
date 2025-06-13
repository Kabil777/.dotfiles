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

local dropbar = require("dropbar")
local sources = require("dropbar.sources")
local utils = require("dropbar.utils")

vim.api.nvim_set_hl(0, "DropBarFileName", { fg = "#2ac3de", italic = false })

local custom_path = {
	get_symbols = function(buff, win, cursor)
		local symbols = require("dropbar.sources.path").get_symbols(buff, win, cursor)
		-- Keep only the last item (the filename)
		local filename_symbol = symbols[#symbols]

		-- Customize filename appearance
		filename_symbol.name_hl = "DropBarFileName"

		return { filename_symbol } -- return only the filename
	end,
}

dropbar.setup({
	bar = {
		padding = {
			left = 4,
			right = 4,
		},
		sources = function(buf, _)
			if vim.bo[buf].ft == "markdown" then
				return {
					custom_path,
					sources.markdown,
				}
			end
			if vim.bo[buf].buftype == "terminal" then
				return {
					sources.terminal,
				}
			end
			return {
				custom_path,
				utils.source.fallback({
					sources.lsp,
					sources.treesitter,
				}),
			}
		end,
	},
})
-- Add this to your Neovim configuration
-- Set the hover/navigation selection background color
vim.api.nvim_set_hl(0, "DropBarMenuHoverEntry", { bg = "#5E81AC", fg = "#292e42" })

local x = vim.diagnostic.severity
vim.diagnostic.config({
	virtual_text = {
		prefix = "■", -- Could be '●', '▎', 'x'
	},
	signs = { text = { [x.ERROR] = " 󰅙", [x.WARN] = " ", [x.INFO] = " 󰋼", [x.HINT] = " 󰌵" } },
	underline = false,
	update_in_insert = false,
	severity_sort = false,
})

-- Set up DAP signs for breakpoints and debugging
vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#F7768E" })
vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "DapBreakpoint", linehl = "", numhl = "" })

require("aerial").setup({
	filter_kind = false,
	layout = {
		min_width = 30,
	},
	show_guides = true,
	guides = {
		mid_item = "├─",
		last_item = "└─",
		nested_top = "│ ",
		whitespace = "  ",
	},
	on_attach = function(bufnr)
		vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
		vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
	end,
})
vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")
vim.lsp.get_clients({ bufnr = 0 })

-- to turn-off jdtls synatx highlighting
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		client.server_capabilities.semanticTokensProvider = nil
	end,
})

-- code-snap setup
require("codesnap").setup({
	mac_window_bar = true,
	watermark = "Java buddy",
	title = "Java buddy",
	bg_theme = "bamboo",
	has_breadcrumbs = true,
	has_line_number = false,
	show_workspace = true,
})

require("urlview").setup({})
vim.lsp.handlers["workspace/executeClientCommand"] = function(_, _, _, _)
	return {}
end
