local theme_colors = require('catppuccin.palettes').get_palette 'mocha'
return {
  'rachartier/tiny-devicons-auto-colors.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  event = 'VeryLazy',
  opts = {
    colors = theme_colors,
  },
}
