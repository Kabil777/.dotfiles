require("nvchad.configs.lspconfig").defaults()

require("mason-lspconfig").setup {
  ensure_installed = {
    "lua_ls",
    "rust_analyzer",
    "hyprls",
    "lemminx",
    "ts_ls",
    "yamlls",
    "helm_ls",
    "basedpyright",
    "bashls",
  },
}
require("mason-tool-installer").setup {
  ensure_installed = {
    "lombok-nightly",
    "stylua",
    "prettier",
    "google-java-format",
    "shfmt",
    "ruff",
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
  "yamlls",
  "helm_ls",
  "basedpyright",
  "rust_analyzer",
}
-- require "configs.java-script.ts-ls"
require("lspconfig").yamlls.setup {
  settings = {
    yaml = {
      schemaStore = {
        enable = true,
        url = "",
      },
      schemas = {
        kubernetes = "*.k8s.yaml",
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
        ["https://raw.githubusercontent.com/SchemaStore/schemastore/master/src/schemas/json/traefik-v2.json"] = "*traefik*.{yaml,yml}",
        ["https://www.schemastore.org/prometheus.json"] = "*prometheus*.{yaml,yml}",
        ["https://www.schemastore.org/grafana-dashboard-5.x.json"] = "grafana-dashboard.yaml",
      },
      format = { enable = true },
    },
  },
}
require("lspconfig").lemminx.setup {
  settings = {
    xml = {
      catalogs = { vim.fn.expand "~/.config/nvim/spring-xsd/xml-catalog.xml" },
    },
  },
}

vim.lsp.enable(servers)
-- read :h vim.lsp.config for changing options of lsp servers
