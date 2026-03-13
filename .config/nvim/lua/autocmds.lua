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
