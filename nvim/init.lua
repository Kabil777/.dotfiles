vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46_cache/"

require("config.lazy")

require("config.lsp") -- Load LSP after cmp
require("config.lsp-core")
require("config.cmp") -- Now that plugins are loaded, load cmp
require("config.null-ls-config")
require("config.keymap")
require("config.telescope-config")
require("config.treesitter")
require("config.genral-configs")
require("config.indent")
require("config.Symbols-outline")
require("config.noice")
