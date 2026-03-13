local options = {
  formatters_by_ft = {
    -- React/TypeScript/JavaScript
    javascript = { "prettier", "prettierd" },
    typescript = { "prettier", "prettierd" },
    javascriptreact = { "prettier", "prettierd" },
    typescriptreact = { "prettier", "prettierd" },

    -- Web files
    css = { "prettier", "prettierd" },
    scss = { "prettier", "prettierd" },
    html = { "prettier", "prettierd" },
    json = { "prettier", "prettierd" },
    yaml = { "prettier", "prettierd" },
    markdown = { "prettierd", "prettier" },

    python = { "ruff" },
    lua = { "stylua" },
    xml = { "xmllint" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 1000,
    lsp_fallback = true,
  },
}

return options
