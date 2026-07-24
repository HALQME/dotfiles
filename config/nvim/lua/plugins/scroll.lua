return {
  "karb94/neoscroll.nvim",
  lazy = true,
  keys = {
    { '<C-u>', '<C-u>', mode = 'n' },
    { '<C-d>', '<C-d>', mode = 'n' },
  },
  config = function()
    require('neoscroll').setup({})
  end,
}
