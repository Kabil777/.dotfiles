vim.lsp.config.gopls.setup {
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork" },
    settings = {
        gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            analyses = {
                unusedparams = true,
            },
        },
    },
}
