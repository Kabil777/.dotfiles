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

-- Telescope Mapping
vim.keymap.set(
	"n",
	"<leader>fg",
	require("telescope").extensions.live_grep_args.live_grep_args,
	{ desc = " Telescope Live Grep" }
)

vim.opt.fillchars = { eob = " " }
vim.o.laststatus = 3
vim.opt.number = true
vim.opt.cursorline = false
vim.keymap.set("n", "<leader>n", ":Neotree toggle<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<Tab>", ":bnext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-Tab>", ":bprev<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>s", ":ShowkeysToggle<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>sy", ":SymbolsOutline<CR>", { noremap = true, silent = true })
vim.opt.termguicolors = true

vim.g.java_debug_delegate_enabled = false

-- lsp keymaps
vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, { desc = "LSP code definition" })
vim.keymap.set("n", "<leader>cD", vim.lsp.buf.declaration, { desc = "LSP code declaration" })
vim.keymap.set("n", "<leader>ci", vim.lsp.buf.implementation, { desc = "LSP code implementation" })
vim.keymap.set("n", "<leader>cR", vim.lsp.buf.references, { desc = "LSP code refrences" })
vim.keymap.set("n", "<leader>K", vim.lsp.buf.hover, { desc = "LSP code hover definition" })
vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "LSP code signatue" })
vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "LSP code rename" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP code action" })
vim.keymap.set("n", "<leader>cf", function()
	vim.lsp.buf.format({ async = true })
end, { desc = "LSP code formatting using lsp" })

-- not required but can be useful for sometimes
-- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
-- vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
-- vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
-- vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)

-- Dap keymaps
local dap = require("dap")
vim.keymap.set("n", "<F5>", dap.continue, { desc = "DAP Continue" })
vim.keymap.set("n", "<F10>", dap.step_over, { desc = "DAP Step Over" })
vim.keymap.set("n", "<F11>", dap.step_into, { desc = "DAP Step Into" })
vim.keymap.set("n", "<F12>", dap.step_out, { desc = "DAP Step Out" })
vim.keymap.set("n", "<F9>", dap.toggle_breakpoint, { desc = "Toggle DAP Breakpoint" })
-- java path
vim.env.JAVA_HOME = "/home/kabil/.sdkman/candidates/java/current"
