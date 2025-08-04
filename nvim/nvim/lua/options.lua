require "nvchad.options"

local keymap = vim.keymap
local harpoon = require "harpoon"

-- add yours here!

local o = vim.o
--o.cursorlineopt = "both" -- to enable cursorline!

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    client.server_capabilities.semanticTokensProvider = nil
  end,
})

o.foldcolumn = "1" -- '0' is not bad
o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
o.foldlevelstart = 99
o.foldenable = true
o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

harpoon:setup()
vim.lsp.handlers["workspace/executeClientCommand"] = function(_, _, _, _)
  return {} 
end
vim.keymap.set("n", "<a-a>", function()
  harpoon:list():add()
end, { desc = "Add file to Harpoon" })

-- Toggle Harpoon UI
vim.keymap.set("n", "<a-m>", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Harpoon Menu" })

-- Navigate to marked files
vim.keymap.set("n", "<a-1>", function()
  harpoon:list():select(1)
end)
vim.keymap.set("n", "<a-2>", function()
  harpoon:list():select(2)
end)
vim.keymap.set("n", "<a-3>", function()
  harpoon:list():select(3)
end)
vim.keymap.set("n", "<a-4>", function()
  harpoon:list():select(4)
end)
vim.keymap.set("n", "<a-n>", function()
  harpoon:list():next()
end)
vim.keymap.set("n", "<a-p>", function()
  harpoon:list():prev()
end)

vim.keymap.set("n", "<a-d>", function()
  local harpoon = require("harpoon")
  local list = harpoon:list()
  local current_path = vim.fn.expand("%:p")
  for i, item in ipairs(list.items) do
    if item.value == current_path then
      list:remove(i)
      print("Removed from Harpoon:", current_path)
      return
    end
  end
  print("File not in Harpoon list.")
end, { desc = "Remove current file from Harpoon" })


-- Set custom colors for popup titles
vim.api.nvim_set_hl(0, "FloatTitle", {
  fg = "#7aa2f7", -- white text
  bg = "#1a1b26", -- dark background
  bold = true,
})
vim.o.foldmethod = "indent" -- Or use "syntax", "manual", or "expr"
vim.o.foldlevel = 99        -- Start with all folds open
vim.o.foldenable = true     -- Enable folding
vim.o.foldcolumn = "0"

require("dapui").setup()

local dap, dapui = require "dap", require "dapui"

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
