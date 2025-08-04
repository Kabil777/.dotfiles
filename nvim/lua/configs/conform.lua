local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    -- css = { "prettier" },
    css = { "prettier" },
    html = { "prettier" },
    java = { "google_java_format" },
    python = { "ruff" },
    javascript = { "prettier" },
    -- html = { "prettier" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}
return options
