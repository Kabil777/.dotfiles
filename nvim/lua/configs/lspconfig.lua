require("nvchad.configs.lspconfig").defaults()

require("nvim-treesitter").setup {
    ensure_installed = { "java", "go", "javascript", "yaml", "bash", "terraform", "hcl", "xml" },
}

vim.g.lspconfig_disable_yamlls = true
require "configs.javascript.ts_ls"
require("mason-lspconfig").setup {
    ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "hyprls",
        "lemminx",
        "vtsls",
        "yamlls",
        "helm_ls",
        "basedpyright",
        "bashls",
        "terraformls",
        "cssls",
        "tailwindcss",
    },
    automatic_enable = {
        "hypr_ls",
    },
}
require("mason-tool-installer").setup {
    ensure_installed = {
        "lombok-nightly",
        "stylua",
        "luacheck",
        "prettier",
        "google-java-format",
        "shfmt",
        "ruff",
        "shellcheck",
        "checkstyle",
        "terraform",
        "tflint",
        "xmlformatter",
        {
            "spring-boot-tools",
            version = "1.55.1",
        },
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
    "yamlls",
    "lemminx",
    "vtsls",
}
-- require "configs.java-script.ts-ls"
vim.lsp.config("yamlls", {
    filetypes = "yaml",
    settings = {
        yaml = {
            schemaStore = {
                enable = false,
                url = "",
            },
            schemas = {
                kubernetes = "*.k8s.yaml",
                ["/home/kabil/.config/nvim/yaml-schemas/certificate-schema.json"] = "certificate*.yaml",
                ["https://raw.githubusercontent.com/quantumblacklabs/kedro/develop/static/jsonschema/kedro-catalog-0.17.json"] = "conf/**/*.catalog*",
                ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
                ["http://json.schemastore.org/github-action.json"] = ".github/action.{yml,yaml}",
                ["https://json.schemastore.org/ansible-playbook.json"] = "roles/tasks/*.{yml,yaml}",
                ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
                ["https://json.schemastore.org/kustomization.json"] = "kustomization.{yml,yaml}",
                ["http://json.schemastore.org/ansible-playbook.json"] = "*play*.{yml,yaml}",
                ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
                ["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
                ["https://json.schemastore.org/gitlab-ci"] = "*gitlab-ci*.{yml,yaml}",
                ["https://json.schemastore.org/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*api*.{yml,yaml}",
                ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
                ["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] = "*flow*.{yml,yaml}",
                ["https://raw.githubusercontent.com/argoproj/argo-events/master/api/jsonschema/schema.json"] = "*argocd.yaml",
                ["https://raw.githubusercontent.com/SchemaStore/schemastore/master/src/schemas/json/traefik-v2.json"] = "*traefik*.{yaml,yml}",
                ["https://www.schemastore.org/prometheus.json"] = "*prometheus*.{yaml,yml}",
                ["https://www.schemastore.org/grafana-dashboard-5.x.json"] = "grafana-dashboard.yaml",
            },
            format = { enable = true },
        },
    },
})
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
