require "nvchad.autocmds"

-- Autocmd to trigger the Tsserver for react
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "typescriptreact",
    "javascriptreact",
    "typescript",
    "javascript",
  },
  callback = function()
    vim.defer_fn(function()
      -- Try to start all LSP servers
      pcall(vim.cmd.LspStart)
    end, 100)
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    -- Disable the old Vim Python indentation script
    vim.bo.indentexpr = nil
    vim.bo.indentkeys = nil
    -- Use modern indentation instead
    vim.bo.autoindent = true
    vim.bo.smartindent = true
  end,
})
