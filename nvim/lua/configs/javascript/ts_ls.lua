local handlers = require "configs.handlers"
local base = require "nvchad.configs.lspconfig"

local capabilities = require("blink.cmp").get_lsp_capabilities(base.capabilities)

vim.lsp.config("ts_ls", {
    cmd = { vim.fn.stdpath "data" .. "/mason/bin/typescript-language-server", "--stdio" },
    filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
    },
    init_options = {
        hostInfo = "neovim",
    },
    on_init = base.on_init,
    on_attach = function(client, bufnr)
        base.on_attach(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
    end,
    capabilities = capabilities,
    workspace_required = false,
    root_markers = {
        "tsconfig.json",
        "jsconfig.json",
        "package.json",
        "pnpm-workspace.yaml",
        "turbo.json",
        ".git",
    },
    handlers = {
        ["textDocument/definition"] = handlers.tsserverDefinition,
    },
})
