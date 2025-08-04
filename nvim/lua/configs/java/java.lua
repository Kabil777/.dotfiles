return {
  "mfussenegger/nvim-jdtls",
  ft = { "java", "properties", "yaml", "yml" },
  config = function()
    local jdtls = require "jdtls"
    local spring_boot = require "spring_boot"

    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
    local workspace_dir = vim.fn.stdpath "data" .. "/site/java/workspace-root/" .. project_name

    local bundles = {
      vim.fn.expand "$MASON/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar",
    }
    vim.list_extend(bundles, vim.split(vim.fn.glob "$MASON/share/java-test/*.jar", "\n"))

    -- Add Spring Boot extensions
    local spring_boot_extensions = require("spring_boot").java_extensions()
    vim.list_extend(bundles, spring_boot_extensions)
    -- Setup LSP capabilities
    local capabilities = require("blink.cmp").get_lsp_capabilities()
    jdtls.extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

    -- Add your Java debug and test bundles here
    -- For example:
    -- table.insert(bundles, vim.fn.expand("$MASON/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar"))
    -- vim.list_extend(bundles, vim.split(vim.fn.glob("$MASON/share/java-test/*.jar"), "\n"))

    -- Add Spring Boot extensions
    -- local spring_boot_extensions = require("spring_boot").java_extensions()
    vim.list_extend(bundles, spring_boot_extensions)
    local config = {
      cmd = {
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-javaagent:" .. vim.fn.expand "$MASON/packages/lombok-nightly/lombok.jar",
        "-Xms1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",
        "-jar",
        vim.fn.glob "$MASON/share/jdtls/plugins/org.eclipse.equinox.launcher_*.jar",
        "-configuration",
        vim.fn.expand "$MASON/share/jdtls/config",
        "-data",
        workspace_dir,
      },
      capabilities = capabilities,
      root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew" }),
      settings = {
        java = {
          eclipse = { downloadSources = true },
          configuration = { updateBuildConfiguration = "interactive" },
          maven = { downloadSources = true },
          implementationsCodeLens = { enabled = true },
          referencesCodeLens = { enabled = true },
          inlayHints = { parameterNames = { enabled = "all" } },
          signatureHelp = { enabled = true },
          completion = {
            favoriteStaticMembers = {
              "org.hamcrest.MatcherAssert.assertThat",
              "org.hamcrest.Matchers.*",
              "org.hamcrest.CoreMatchers.*",
              "org.junit.jupiter.api.Assertions.*",
              "java.util.Objects.requireNonNull",
              "java.util.Objects.requireNonNullElse",
              "org.mockito.Mockito.*",
            },
          },
          sources = {
            organizeImports = {
              starThreshold = 9999,
              staticStarThreshold = 9999,
            },
          },
        },
      },
      init_options = {
        bundles = bundles,
        -- vim.fn.expand "$MASON/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar",
        -- -- unpack remaining bundles
        -- (table.unpack or unpack)(vim.split(vim.fn.glob "$MASON/share/java-test/*.jar", "\n", {})),
      },
      handlers = {
        ["$/progress"] = function() end, -- disable progress updates.
      },
      filetypes = { "java" },
      on_attach = function(...)
        require("jdtls").setup_dap { hotcodereplace = "auto" }
      end,
    }

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "java", "properties", "yaml", "yml" },
      callback = function()
        require("jdtls").start_or_attach(config)
      end,
    })
  end,
}
