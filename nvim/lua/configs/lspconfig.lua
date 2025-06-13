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
local servers = { "html", "cssls", "lua_ls", "hyprls", "yamlls", "helm_ls", "basedpyright" }

require("java").setup {
  notifications = {
    dap = false,
  },
  jdtls = {
    version = "v1.43.0",
  },

  lombok = {
    version = "nightly",
  },
  java_debug_adapter = {
    enable = true,
    version = "0.58.1",
  },
  spring_boot_tools = {
    enable = false,
    version = "1.55.1",
  },
}

require("lspconfig").jdtls.setup {
  handlers = {
    ["$/progress"] = function(_, result, ctx) end,
  },
  settings = {
    java = {
      signatureHelp = {
        enabled = true,
      },
      inlayHints = {
        parameterNames = {
          enabled = "all",
          exclusions = { "this" },
        },
      },
    },
  },
}
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
        ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
        ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
        ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
        ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
        ["http://json.schemastore.org/ansible-playbook"] = "*play*.{yml,yaml}",
        ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
        ["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
        ["https://json.schemastore.org/gitlab-ci"] = "*gitlab-ci*.{yml,yaml}",
        ["https://json.schemastore.org/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*api*.{yml,yaml}",
        ["https://json.schemastore.org/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
        ["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] = "*flow*.{yml,yaml}",
      },
      format = { enable = true },
    },
  },
}

vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers
