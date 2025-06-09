return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,

    config = function()
      require('catppuccin').setup {
        transparent_background = true,
        integrations = {
          hop = true,
          harpoon = true,
          mason = true,
          neotest = true,
          notify = true,
          noice = true,
          dadbod_ui = true,
          gitsigns = {
            enabled = true,
          },
          snacks = {
            enabled = true,
          },
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { 'italic' },
              hints = { 'italic' },
              warnings = { 'italic' },
              information = { 'italic' },
              ok = { 'italic' },
            },
            underlines = {
              errors = { 'underline' },
              hints = { 'underline' },
              warnings = { 'underline' },
              information = { 'underline' },
              ok = { 'underline' },
            },
            inlay_hints = {
              background = true,
            },
          },
          lsp_trouble = true,
          which_key = true,
        },
        custom_highlights = function(colors)
          return {
            Comment = { fg = colors.overlay1 },
            CmpBorder = { fg = colors.surface0 },
            Pmenu = { bg = colors.none },
            LineNr = { fg = colors.surface2 },
          }
        end,
      }
    end,
  },
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
  {
    'thesimonho/kanagawa-paper.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
  },
  { 'sainnhe/gruvbox-material' },
  { 'sainnhe/everforest' },
  {
    '2nthony/vitesse.nvim',
    dependencies = {
      'tjdevries/colorbuddy.nvim',
    },
  },
  {
    'vague2k/vague.nvim',
    config = function()
      require('vague').setup {
        -- "none" is the same thing as default. But "italic" and "bold" are also valid options
        boolean = 'bold',
        number = 'none',
        float = 'none',
        error = 'bold',
        comments = 'italic',
        conditionals = 'none',
        functions = 'none',
        headings = 'bold',
        operators = 'none',
        strings = 'italic',
        variables = 'none',

        -- keywords
        keywords = 'none',
        keyword_return = 'italic',
        keywords_loop = 'none',
        keywords_label = 'none',
        keywords_exception = 'none',

        -- builtin
        builtin_constants = 'bold',
        builtin_functions = 'none',
        builtin_types = 'bold',
        builtin_variables = 'none',
      }
    end,
  },
}
