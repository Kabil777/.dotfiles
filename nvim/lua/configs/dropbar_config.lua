local dropbar = require "dropbar"
local sources = require "dropbar.sources"
local utils = require "dropbar.utils"

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

return {

  require("aerial").setup {
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
  },
  dropbar.setup {
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
          utils.source.fallback {
            sources.lsp,
            sources.treesitter,
          },
        }
      end,
    },
  },
}
