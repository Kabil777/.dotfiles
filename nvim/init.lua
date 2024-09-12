require("config.lazy")

--vim key binds
vim.cmd("set number")
vim.cmd("set shiftwidth=2")
local modes = { 'n', 'i', 'v' } -- Normal, Insert, Visual modes
local msg = [[<cmd>echohl Error | echo "Arrow keys are disabled! Use hjkl keys." | echohl None<CR>]]
vim.opt.fillchars:append({ eob = " " })

-- List of arrow keys
local keys = { '<Up>', '<Down>', '<Left>', '<Right>' }

for _, mode in ipairs(modes) do
	for _, key in ipairs(keys) do
		vim.keymap.set(mode, key, msg, { noremap = true, silent = false })
	end
end
