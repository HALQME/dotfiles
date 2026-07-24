return {
  {
    'echasnovski/mini.nvim',
    event = 'VeryLazy',
    config = function()
      -- Better around/inside textobjects
      require('mini.ai').setup()

      -- Highlight word under cursor
      require('mini.cursorword').setup()

      -- Visualize and work with indent scope
      require('mini.indentscope').setup({
        symbol = '│',
        options = { try_as_border = true },
      })

      -- Fast navigation with f/F/t/T
      require('mini.jump').setup()

      -- Extend and create a/i textobjects
      require('mini.bracketed').setup()

      require('mini.files').setup({
        windows = {
          preview = true,
          width_focus = 30,
          width_preview = 60,
        },
        options = {
          use_as_default_explorer = true,
          permanent_delete = false,
        },
      })

      vim.keymap.set('n', '<leader>e', function()
        local files = require('mini.files')
        if files.close() then
          return
        end

        local path = vim.api.nvim_buf_get_name(0)
        if vim.bo.buftype ~= '' or vim.fn.filereadable(path) == 0 then
          path = vim.fn.getcwd()
        end
        files.open(path, true)
      end, { desc = 'Toggle File Explorer' })
    end,
  },
}
