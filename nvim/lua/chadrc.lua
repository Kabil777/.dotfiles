-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "tokyodark",

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },

    NormalFloat = { fg = "NONE", bg = "NONE" },
    CmpBorder = { link = "FloatBorder" },
    CmpDocBorder = { link = "CmpBorder" },
    CmpDoc = { bg = "NONE" },
    NvimTreeCursorLine = { link = "CursorLine" },

    Pmenu = { bg = "#282828", fg = "#d5c4a1" },
  },
}
M.lsp = {
  signature = false,
}
M.ui = {
  statusline = {
    theme = "default",
    order = { "mode", "file", "git", "diagnostics", "%=", "%=", "cursor", "lsp", "cwd" },
    modules = {
      cursor = "%#St_pos_text# %l:%c ",
    },

    cmp = {
      lspkind_text = false,
      style = "default", -- default/flat_light/flat_dark/atom/atom_colored
      format_colors = {
        lsp = true,
      },
    },
  },
  tabufline = {
    enabled = false,
    lazyload = false,
    order = { "buffers", "tabs", "btns" },
    modules = nil,
  },
  lsp = {
    signature = false,
    hover = false,
  },
}
vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "Debug", linehl = "", numhl = "" })

return M
