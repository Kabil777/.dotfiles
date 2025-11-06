local options = {
    formatters_by_ft = {
        lua = { "stylua" },
        -- css = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        java = { "google-java-format" },
        python = { "ruff" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "biome" },
        typescriptreact = { "prettier" },
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
        timeout_ms = 500,
        lsp_fallback = true,
    },
}
return options
