require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<Tab>", ":bnext<CR>", { noremap = true, silent = true })
map("n", "<S-Tab>", ":bprev<CR>", { noremap = true, silent = true })

map("n", "<leader>cd", vim.lsp.buf.definition, { desc = "LSP code definition" })
map("n", "<leader>cD", vim.lsp.buf.declaration, { desc = "LSP code declaration" })
map("n", "<leader>ci", vim.lsp.buf.implementation, { desc = "LSP code implementation" })
map("n", "<leader>cR", vim.lsp.buf.references, { desc = "LSP code refrences" })
map("n", "<leader>K", vim.lsp.buf.hover, { desc = "LSP code hover definition" })
map("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "LSP code signatue" })
map("n", "<leader>cr", vim.lsp.buf.rename, { desc = "LSP code rename" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP code action" })
map("n", "<leader>cf", function()
  vim.lsp.buf.format { async = true }
end, { desc = "LSP code formatting using lsp" })

vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
-- Dap keymaps
local dap = require "dap"
vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "DAP Continue" })
vim.keymap.set("n", "<leader>dso", dap.step_over, { desc = "DAP Step Over" })
vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "DAP Step Into" })
vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "DAP Step Out" })
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle DAP Breakpoint" })
vim.keymap.set("n", "<leader>dx", function()
  require("dapui").close()
end, { desc = "Close DAP UI" })
