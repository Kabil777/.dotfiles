for _, v in ipairs(vim.fn.readdir(vim.g.base46_cache)) do
	dofile(vim.g.base46_cache .. v)
end
local warnings_enabled = true

vim.keymap.set("n", "<leader>tw", function()
	if warnings_enabled then
		-- Disable warnings
		vim.diagnostic.config({
			virtual_text = { severity = { min = vim.diagnostic.severity.ERROR } },
			signs = { severity = { min = vim.diagnostic.severity.ERROR } },
			underline = { severity = { min = vim.diagnostic.severity.ERROR } },
		})
		warnings_enabled = false
	else
		-- Enable warnings
		vim.diagnostic.config({
			virtual_text = { severity = vim.diagnostic.severity.WARN },
			signs = { severity = vim.diagnostic.severity.WARN },
			underline = { severity = vim.diagnostic.severity.WARN },
		})
		warnings_enabled = true
	end
end, { desc = "Toggle Warnings" })

vim.opt.fillchars = { eob = " " }
vim.o.laststatus = 3
vim.opt.number = true
vim.opt.cursorline = true
vim.keymap.set("n", "<C-n>", ":Neotree toggle<CR>")
vim.api.nvim_set_keymap("n", "<Tab>", ":bnext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-Tab>", ":bprev<CR>", { noremap = true, silent = true })
vim.opt.termguicolors = true
