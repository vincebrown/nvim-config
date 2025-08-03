return {
  {
    'echasnovski/mini.nvim',
    event = 'VeryLazy',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      require('mini.splitjoin').setup()

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- Pair matching () {} []
      require('mini.pairs').setup()

      -- commenting out code
      require('mini.comment').setup()

      require('mini.cursorword').setup()

      -- Move lines in N an V mode
      require('mini.move').setup {
        mappings = {
          left = '<C-M-h>',
          right = '<C-M-l>',
          down = '<C-M-j>',
          up = '<C-M-k>',
          line_left = '<C-M-h>',
          line_right = '<C-M-l>',
          line_down = '<C-M-j>',
          line_up = '<C-M-k>',
        },
      }

      require('mini.icons').setup {
        file = {
          ['.eslintrc.js'] = { glyph = '󰱺', hl = 'MiniIconsYellow' },
          ['.node-version'] = { glyph = '', hl = 'MiniIconsGreen' },
          ['.prettierrc'] = { glyph = '', hl = 'MiniIconsPurple' },
          ['.yarnrc.yml'] = { glyph = '', hl = 'MiniIconsBlue' },
          ['eslint.config.js'] = { glyph = '󰱺', hl = 'MiniIconsYellow' },
          ['package.json'] = { glyph = '', hl = 'MiniIconsGreen' },
          ['tsconfig.json'] = { glyph = '', hl = 'MiniIconsAzure' },
          ['tsconfig.build.json'] = { glyph = '', hl = 'MiniIconsAzure' },
          ['yarn.lock'] = { glyph = '', hl = 'MiniIconsBlue' },
          ['.go-version'] = { glyph = '', hl = 'MiniIconsBlue' },
        },
        filetype = {
          gotmpl = { glyph = '󰟓', hl = 'MiniIconsGrey' },
        },
        lsp = {
          array = { glyph = '', hl = 'MiniIconsOrange' },
          boolean = { glyph = '', hl = 'MiniIconsOrange' },
          class = { glyph = '󰠱', hl = 'MiniIconsPurple' },
          color = { glyph = '', hl = 'MiniIconsRed' },
          constant = { glyph = '', hl = 'MiniIconsOrange' },
          constructor = { glyph = '', hl = 'MiniIconsAzure' },
          enum = { glyph = '', hl = 'MiniIconsPurple' },
          enummember = { glyph = '', hl = 'MiniIconsYellow' },
          event = { glyph = '', hl = 'MiniIconsRed' },
          field = { glyph = '󰜢', hl = 'MiniIconsYellow' },
          file = { glyph = '', hl = 'MiniIconsBlue' },
          folder = { glyph = '󰉋', hl = 'MiniIconsBlue' },
          ['function'] = { glyph = '󰆧', hl = 'MiniIconsCyan' },
          interface = { glyph = '', hl = 'MiniIconsPurple' },
          key = { glyph = '', hl = 'MiniIconsYellow' },
          keyword = { glyph = '', hl = 'MiniIconsCyan' },
          method = { glyph = '', hl = 'MiniIconsAzure' },
          module = { glyph = '󰕳', hl = 'MiniIconsPurple' },
          namespace = { glyph = '', hl = 'MiniIconsRed' },
          null = { glyph = '', hl = 'MiniIconsGrey' },
          number = { glyph = '', hl = 'MiniIconsOrange' },
          object = { glyph = '', hl = 'MiniIconsGrey' },
          operator = { glyph = '󰆕', hl = 'MiniIconsCyan' },
          package = { glyph = '', hl = 'MiniIconsPurple' },
          property = { glyph = '', hl = 'MiniIconsYellow' },
          reference = { glyph = '󰈇', hl = 'MiniIconsCyan' },
          snippet = { glyph = '', hl = 'MiniIconsGreen' },
          string = { glyph = '', hl = 'MiniIconsGreen' },
          struct = { glyph = '󰙅', hl = 'MiniIconsPurple' },
          text = { glyph = '󰉿', hl = 'MiniIconsGreen' },
          typeparameter = { glyph = '󰊄', hl = 'MiniIconsCyan' },
          unit = { glyph = '', hl = 'MiniIconsCyan' },
          value = { glyph = '󰎠', hl = 'MiniIconsBlue' },
          variable = { glyph = '󰀫', hl = 'MiniIconsCyan' },
        },
        init = function()
          package.preload['nvim-web-devicons'] = function()
            require('mini.icons').mock_nvim_web_devicons()
            return package.loaded['nvim-web-devicons']
          end
        end,
      }
      MiniIcons.tweak_lsp_kind()
    end,
  },
}
