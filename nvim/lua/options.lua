require "nvchad.options"

vim.diagnostic.config {
  virtual_text = true,
  signs = true,
  underline = false,
}

-- vim.diagnostic.config { virtual_text = false } -- Disable default virtual text
local o = vim.o
-- vim.api.nvim_create_autocmd("LspAttach", {
--   callback = function(args)
--     local client = vim.lsp.get_client_by_id(args.data.client_id)
--     client.server_capabilities.semanticTokensProvider = nil
--   end,
-- })
vim.diagnostic.config {
  virtual_text = true,
  underline = false,
  severity_sort = true,
  signs = {
    text = {
      -- Alas nerdfont icons don't render properly on Medium!
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = " ",
      [vim.diagnostic.severity.INFO] = " ",
    },
  },
}

o.foldenable = true
o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

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
vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.tf", "*.tfvars", "*.tfstate", "*.tfstate.backup" },
  callback = function()
    vim.bo.filetype = "terraform"
  end,
})

o.cmdheight = 1
o.number = true
o.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
