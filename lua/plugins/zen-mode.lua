-- ZenMode (move to mini?)
return {
  {
    'folke/zen-mode.nvim',
    opts = {
      relativenumber = true,
    },
    config = function()
      vim.keymap.set('n', '<leader>cz', ':ZenMode<CR>')
    end,
  },
}
