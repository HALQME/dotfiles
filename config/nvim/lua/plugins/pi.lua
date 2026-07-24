return {
  {
    'pablopunk/pi.nvim',
    cmd = { 'PiAsk', 'PiAskSelection', 'PiCancel', 'PiLog' },
    keys = {
      { '<leader>pa', '<cmd>PiAsk<CR>', mode = 'n', desc = 'Ask Pi' },
      { '<leader>pa', '<cmd>PiAskSelection<CR>', mode = 'x', desc = 'Ask Pi about Selection' },
      { '<leader>pc', '<cmd>PiCancel<CR>', mode = 'n', desc = 'Cancel Pi' },
      { '<leader>pl', '<cmd>PiLog<CR>', mode = 'n', desc = 'Pi Log' },
    },
    opts = {},
  },
}
