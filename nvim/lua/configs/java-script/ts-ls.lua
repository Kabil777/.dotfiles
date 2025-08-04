local lspconfig = require "lspconfig"
local handlers = require "configs.handlers"

-- potentially add https://github.com/yioneko/nvim-vtsls for more goodies
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities())

lspconfig.tsserver.setup {
  init_options = {
    hostInfo = "neovim",
  },
  on_init = function(client)
    -- This makes sure tsserver is not used for formatting (prefer prettier)
    client.server_capabilities.documentFormattingProvider = false
  end,
  capabilities = capabilities,
  on_attach = function(client, bufnr) end,
  handlers = {
    ["textDocument/definition"] = handlers.tsserverDefinition,
  },
}
