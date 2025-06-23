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
      { '<leader>h', group = 'Harpoon' },
      { '<leader>t', group = 'Test' },
      { '<leader>u', group = 'Toggle' },
      { '<leader>x', group = 'Trouble' },
      { '<leader>g', group = 'Git' },
    }
  end,
}
