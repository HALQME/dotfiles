return {
  'stevearc/aerial.nvim',
  keys = {
    { '<leader>a', '<cmd>AerialToggle!<CR>', desc = 'Toggle Symbols' },
    { '<leader>ap', '<cmd>AerialPrev<CR>', desc = 'Previous Symbol' },
    { '<leader>an', '<cmd>AerialNext<CR>', desc = 'Next Symbol' },
  },
  config = function()
    require('aerial').setup({
      backends = { 'treesitter', 'lsp', 'markdown', 'asciidoc', 'man' },
      filter_kind = false,
      layout = {
        max_width = { 80, 0.4 },
        width = nil,
        min_width = 40,
      }
    })
  end,
}
