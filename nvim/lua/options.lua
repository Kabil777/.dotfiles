require "nvchad.options"
local installed_formatters = {
  "stylua",
  "prettier",
  "google_java_format",
  "shfmt",
  "ruff",
  "xmlformatter",
}

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    local mason_registry = require "mason-registry"
    for _, tool in ipairs(installed_formatters) do
      local ok, p = pcall(mason_registry.get_package, tool)
      if ok and not p:is_installed() then
        p:install()
      end
    end
  end,
})

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

local o = vim.o
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    client.server_capabilities.semanticTokensProvider = nil
  end,
})

o.foldcolumn = "1" -- '0' is not bad
o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
o.foldlevelstart = 99
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
