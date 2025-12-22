local options = {
    formatters_by_ft = {
        lua = { "stylua" },
        -- css = { "prettier" },
        css = { "prettierd" },
        html = { "prettierd" },
        java = { "google-java-format" },
        python = { "ruff" },
        go = { "golines", "gofumpt", "goimports-reviser" },
        javascript = { "biome" },
        typescript = { "biome" },
        javascriptreact = { "biome" },
        typescriptreact = { "biome" },
        terraform = { "terraform_fmt" },
        -- html = { "prettier" },
    },

    formatters = {
        ["google-java-format"] = {
            command = "google-java-format",
            args = { "--aosp", "-" }, -- forces wrapping after 60 chars
            stdin = true,
        },
    },
    format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 1000,
        lsp_fallback = true,
    },
}
return options
