return {
  { 'catppuccin/nvim', name = 'catppuccin', priority = 1000 },
  {
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      vim.cmd.hi 'Comment gui=none'
    end,
  },
  { 'rose-pine/neovim', name = 'rose-pine' },
  { 'savq/melange-nvim' },
  { 'AhmedAbdulrahman/aylin.vim' },
  { 'rebelot/kanagawa.nvim' },
  { 'sainnhe/gruvbox-material' },
  { 'sainnhe/everforest' },
  { 'EdenEast/nightfox.nvim' },
  {
    '2nthony/vitesse.nvim',
    dependencies = {
      'tjdevries/colorbuddy.nvim',
    },
  },
}
