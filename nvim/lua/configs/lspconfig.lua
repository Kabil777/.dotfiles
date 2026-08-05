require("nvim-treesitter").setup {
    ensure_installed = { "java", "go", "javascript", "yaml", "json", "bash", "terraform", "hcl", "xml" },
}

require("nvchad.configs.lspconfig").defaults()

-- vim.g.lspconfig_disable_yamlls = true
require "configs.javascript.ts_ls"
require "configs.yaml.yamlls"

require("mason-lspconfig").setup {
    ensure_installed = {
        "gopls",
        "lua_ls",
        "rust_analyzer",
        "hyprls",
        "lemminx",
        "ts_ls",
        "prismals",
        "helm_ls",
        "basedpyright",
        "bashls",
        "yamlls",
        "terraformls",
        "cssls",
        "tailwindcss",
        "biome",
        "nginx_language_server",
    },
}
require("mason-tool-installer").setup {
    ensure_installed = {
        "lombok-nightly",
        "stylua",
        "luacheck",
        "prettierd",
        "google-java-format",
        "shfmt",
        "ruff",
        "shellcheck",
        "checkstyle",
        "jdtls",
        "java-test",
        "tree-sitter-cli",
        "terraform",
        "tflint",
        "xmlformatter",
        "nginx-language-server",
        "prismals",
        -- Held at current installed version; avoid auto-updating to 1.55.1.
        -- {
        --     "spring-boot-tools",
        --     version = "1.55.1",
        -- },
        "vscode-spring-boot-tools",
    },
}

local servers = {
    "html",
    "cssls",
    "lua_ls",
    "hyprls",
    "helm_ls",
    "basedpyright",
    "rust_analyzer",
    "bashls",
    "tailwindcss",
    "lemminx",
    "ts_ls",
    "gopls",
    "nginx_language_server",
    "yamlls",
    "biome",
    "prismals",
}
-- require "configs.java-script.ts-ls"
-- disable auto setup
vim.lsp.config("lemminx", {
    settings = {
        xml = {
            catalogs = { vim.fn.expand "~/.config/nvim/spring-xsd/xml-catalog.xml" },
        },
    },
})

vim.lsp.config("cssls", {
    settings = {
        css = { validate = true },
        less = { validate = true },
        scss = { validate = true },
    },
})

vim.lsp.config("tailwindcss", {
    filetypes = {
        "html",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "vue",
        "svelte",
        "astro",
    },
})

vim.lsp.config("terraformls", {
    flags = { debounce_text_changes = 150 },
})

vim.lsp.config("qmlls", {
    filetypes = { "qml", "qmljs" },
    cmd = { "qmlls" },
    cmd_env = {
        QML2_IMPORT_PATH = "/usr/lib/qt6/qml",
        QML_IMPORT_PATH = "/usr/lib/qt6/qml",
    },
})

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

vim.lsp.enable(servers)
