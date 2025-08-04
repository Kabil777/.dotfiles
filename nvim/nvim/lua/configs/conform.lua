local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    -- css = { "prettier" },
    html = { "prettier" },
    java = { "google_java_format" },
    python = { "ruff" },javascript = { "prettier" },
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}


return options
