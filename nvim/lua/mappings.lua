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
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP code action" })
map("n", "<leader>cf", function()
    vim.lsp.buf.format { async = true }
end, { desc = "LSP code formatting using lsp" })

map("n", "<leader>a", "<cmd>AerialToggle!<CR>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
-- Dap keymaps
local dap = require "dap"
map("n", "<leader>dc", dap.continue, { desc = "DAP Continue" })
map("n", "<leader>dso", dap.step_over, { desc = "DAP Step Over" })
map("n", "<leader>di", dap.step_into, { desc = "DAP Step Into" })
map("n", "<leader>do", dap.step_out, { desc = "DAP Step Out" })
map("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle DAP Breakpoint" })
map("n", "<leader>dx", function()
    require("dapui").close()
end, { desc = "Close DAP UI" })

map("n", "<C-h>", "TmuxNavigateLeft")

-- mini overlays highlights
-- vim.api.nvim_set_hl(0, "FloatTitle", { fg = "#7aa2f7", bg = "#11121d", bold = true })
-- vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = "#414868", nocombine = true })
-- vim.api.nvim_set_hl(0, "MiniPickPrompt", { fg = "#9ece6a", nocombine = true })
local popup_hl = vim.api.nvim_create_augroup("PopupHighlights", { clear = true })

local function fix_noice_popup()
    vim.api.nvim_set_hl(0, "NoiceCmdlinePopup", { link = "Normal" })
    vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder", { link = "FloatBorder" })
    vim.api.nvim_set_hl(0, "NoiceCmdlinePopupTitle", { link = "Title" })

    vim.api.nvim_set_hl(0, "NoiceCmdlinePrompt", { link = "Normal" })
    vim.api.nvim_set_hl(0, "NoiceCmdlineIcon", { link = "Normal" })
end

vim.api.nvim_create_autocmd("ColorScheme", {
    callback = fix_noice_popup,
})

fix_noice_popup()

local function set_popup_highlights()
    vim.api.nvim_set_hl(0, "NoiceCmdlinePopup", { link = "NormalFloat" })
    vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder", { link = "FloatBorder" })
    vim.api.nvim_set_hl(0, "NoiceCmdlinePopupTitle", { link = "FloatTitle" })
    vim.api.nvim_set_hl(0, "FloatTitle", { link = "Title" })
    vim.api.nvim_set_hl(0, "MiniPickPrompt", { link = "FloatTitle" })
    vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { link = "Comment" })
end

vim.api.nvim_create_autocmd("ColorScheme", {
    callback = set_popup_highlights,
})

set_popup_highlights()
vim.api.nvim_create_autocmd("User", {
    pattern = "MiniFilesWindowOpen",
    callback = function(args)
        local win_id = args.data.win_id
        vim.wo[win_id].winblend = 15 -- transparency
        local config = vim.api.nvim_win_get_config(win_id)
        config.border = "single"
        config.title_pos = "left"
        local buf_id = args.data.buf_id
        local lines = vim.api.nvim_buf_get_lines(buf_id, 0, -1, false)
        for i, line in ipairs(lines) do
            -- Adds 2 spaces before every line
            lines[i] = "  " .. line
        end
        vim.api.nvim_win_set_config(win_id, config)
    end,
})

--# noice hlgroup
-- vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder", { fg = "#9ece6a", bg = "#11121d" })
-- vim.api.nvim_set_hl(0, "NoiceCmdlinePopup", { bg = "#11121d", fg = "#c0caf5" })
local function add_italic_to(group)
    local hl = vim.api.nvim_get_hl(0, { name = group }) or {}
    hl.italic = true
    vim.api.nvim_set_hl(0, group, hl)
end

--# italic style to keyords,operator
local groups = {
    "Keyword",
    "Conditional",
    "Repeat",
    "Statement",
    "Operator",
    "Exception",
    "@keyword",
    "@conditional",
    "@repeat",
    "@keyword.return",
    "@keyword.function",
    "@operator",
}

for _, group in ipairs(groups) do
    add_italic_to(group)
end

local function toggle_tree()
    require("nvim-tree.api").tree.toggle()

    local win = vim.api.nvim_get_current_win()
    if vim.bo.filetype == "NvimTree" then
        vim.wo[win].winhighlight = table.concat({
            "Normal:Normal",
            "NormalNC:Normal",
            "NormalFloat:Normal",
            "EndOfBuffer:Normal",
            "FloatBorder:FloatBorder",
            "CursorLine:Normal",
        }, ",")
    end
end

vim.keymap.set("n", "<leader>e", toggle_tree)
