return {
  'stevearc/conform.nvim',
  keys = {
    { '<leader>cf', mode = { 'n', 'x' }, desc = 'Format' },
  },
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      javascript = { 'prettierd', 'prettier' },
      typescript = { 'prettierd', 'prettier' },
      javascriptreact = { 'prettierd', 'prettier' },
      typescriptreact = { 'prettierd', 'prettier' },
    },
    format_on_save = {
      timeout_ms = 3000,
      lsp_format = 'fallback',
    },
  },
  config = function(_, opts)
    local conform = require('conform')
    conform.setup(opts)
    vim.keymap.set({ 'n', 'x' }, '<leader>cf', function()
      conform.format({ async = true, lsp_format = 'fallback' })
    end, { desc = 'Format' })
  end,
}
