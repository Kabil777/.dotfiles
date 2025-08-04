require "configs.dap.debug-configurations"
local dap = require "dap"

-- reloads configs and then continues
local function reload_continue()
  if dap.status() == "" then
    package.loaded["configs.dap.debug-configurations"] = nil
  end
  require "configs.dap.debug-configurations"
  dap.continue()
end

vim.api.nvim_create_user_command("MyDapReloadContinue", reload_continue, {})

-- debug adapters
-- Note: the java adapter is set up in jdtls.lua

dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    -- command = '/absolute/path/to/codelldb/extension/adapter/codelldb',
    command = "codelldb",
    args = { "--port", "${port}" },

    -- On windows you may have to uncomment this:
    -- detached = false,
  },
}

dap.adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "js-debug-adapter",
    args = { "${port}" },
  },
}
