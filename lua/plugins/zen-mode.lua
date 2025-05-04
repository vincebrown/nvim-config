return {
  {
    'folke/zen-mode.nvim',
    config = function()
      require('zen-mode').setup {
        window = {
          backdrop = 1,
          height = 1,
          width = 0.8,
          options = {
            number = false,
            relativenumber = false,
            signcolumn = 'no',
            list = false,
            cursorline = false,
          },
        },
      }

      vim.keymap.set('n', '<leader>cz', ':ZenMode<CR>')
    end,
  },
}
