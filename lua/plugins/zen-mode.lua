return {
  -- Lua
  {
    'folke/zen-mode.nvim',
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      relativenumber = true,
    },
    config = function()
      vim.keymap.set('n', '<leader>zm', ':ZenMode<CR>', { desc = '[Z]en [M]ode Toggle' })
    end,
  },
}
