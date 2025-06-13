local M = {}
M.animate = {
  cursor = {
    enable = false,
  },
}
M.files = {
  use_as_default_explorer = true,
  windows = {
    max_number = math.huge,
    preview = false,
    width_focus = 30,
    width_nofocus = 20,
    width_preview = 25,
  },
}
local hipatterns = require "mini.hipatterns"
M.hipatterns = {
  highlighters = {
    fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
    hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
    todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
    note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
    hex_color = hipatterns.gen_highlighter.hex_color(),
  },
}
M.indentscope = {
  symbol = "│",
  options = {
    -- Type of scope's border: which line(s) with smaller indent to
    -- categorize as border. Can be one of: 'both', 'top', 'bottom', 'none'.
    border = "both",

    -- Whether to use cursor column when computing reference indent.
    -- Useful to see incremental scopes with horizontal cursor movements.
    indent_at_cursor = true,

    -- Maximum number of lines above or below within which scope is computed
    n_lines = 10000,

    -- Whether to first check input line to be a border of adjacent scope.
    -- Use it if you want to place cursor on function header to get scope of
    -- its body.
    try_as_border = true,
  },
}

M.ai = {}

M.visits = {
  store = {
    path = vim.fn.stdpath "cache" .. "mini-visits-index",
  },
}
local au_opts = {
  pattern = "MiniStarterOpened",
  callback = function()
    vim.b.miniindentscope_disable = true
  end,
}
vim.api.nvim_create_autocmd("User", au_opts)
package.preload["nvim-web-devicons"] = function()
  require("mini.icons").mock_nvim_web_devicons()
  return package.loaded["nvim-web-devicons"]
end

M.git = {}

M.diff = {
  view = {
    style = "sign",
    signs = { add = " ", change = " ", delete = "" },
  },
}
vim.api.nvim_create_autocmd("User", {
  pattern = "TelescopeLoad",
  callback = function()
    dofile(vim.g.base46_cache .. "telescope")
  end,
})
vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = "#40486a", nocombine = true }) -- Orange, as an example

local starter = require "mini.starter"
M.starter = {
  evaluate_single = true,
  header = table.concat({
    "                                   ",
    "                                   ",
    "                                   ",
    "   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          ",
    "    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ",
    "          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     ",
    "           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ",
    "          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ",
    "   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ",
    "  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ",
    " ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ",
    " ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ ",
    "      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ",
    "       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ",
    "                                   ",
  }, "\n"),
  footer = os.date "%B %d, %I:%M %p",
  items = {
    {
      name = "  Bookmarked Files",
      action = "lua MiniExtra.pickers.visit_paths { filter = 'todo' }",
      section = " Actions ",
    },
    {
      name = "  Lazy Update",
      action = ":Lazy update",
      section = " Actions ",
    },
    {
      name = "  Open Blank File",
      action = ":enew",
      section = " Actions ",
    },
    {
      name = "  Find Files",
      action = "lua MiniPick.builtin.files()",
      section = " Actions ",
    },
    {
      name = "  Recent Files",
      action = "lua MiniExtra.pickers.oldfiles()",
      section = " Actions ",
    },
    {
      name = "  Quit",
      action = ":q!",
      section = " Actions ",
    },
  },
  content_hooks = {
    starter.gen_hook.aligning("center", "center"),
  },
}

return {
  require("mini.ai").setup(M.ai),
  require("mini.git").setup(M.git),
  require("mini.bracketed").setup(),
  require("mini.surround").setup(),
  require("mini.animate").setup(M.animate),
  require("mini.pick").setup(),
  require("mini.starter").setup(M.starter),
  require("mini.files").setup(),
  require("mini.indentscope").setup(M.indentscope),
  require("mini.icons").setup(),
}
