return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  keys = {
    {
      '<leader>?',
      function()
        require('which-key').show { global = false }
      end,
      desc = 'Buffer Local Keymaps (which-key)',
    },
  },
  config = function()
    local wk = require 'which-key'
    wk.setup {
      preset = 'modern',
      layout = {
        width = { min = 20 }, -- min and max width of the columns
        spacing = 5, -- spacing between columns
      },
      icons = {
        mappings = false,
      },
    }
    wk.add {
      { '<leader>f', group = 'Find' },
      { '<leader>s', group = 'Search' },
      { '<leader>b', group = 'Buffer' },
      { '<leader>c', group = 'Code' },
      { '<leader>d', group = 'Debug' },
      { '<leader>g', group = 'Git' },
      { '<leader>h', group = 'Harpoon/Hop' },
      { '<leader>t', group = 'Test' },
      { '<leader>u', group = 'Toggle' },
      { '<leader>v', group = 'View' },
      { '<leader>x', group = 'Trouble' },
    }
  end,
}
