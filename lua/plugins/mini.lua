return {
  -- Better Around/Inside textobjects
  {
    'nvim-mini/mini.ai',
    event = 'VeryLazy',
    config = function()
      -- Built-in textobjects (work without treesitter):
      --  - va)  - [V]isually select [A]round [)]paren
      --  - vi(  - [V]isually select [I]nside [)]paren (all params)
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      --  - da{  - [D]elete [A]round [{]brace
      --  - via  - [V]isually select [I]nside [A]rgument (default)
      --  - daa  - [D]elete [A]round [A]rgument (default, includes comma)
      --
      -- Treesitter textobjects - FUNCTION (f):
      --  - vif  - [V]isually select [I]nside [F]unction body (no signature)
      --  - vaf  - [V]isually select [A]round [F]unction (entire function)
      --  - daf  - [D]elete [A]round [F]unction (entire function)
      --  - cif  - [C]hange [I]nside [F]unction (replace body, keep signature)
      --  - yaf  - [Y]ank [A]round [F]unction (copy entire function)
      --  - vinf - [V]isually select [I]nside [N]ext [F]unction
      --  - vilf - [V]isually select [I]nside [L]ast/previous [F]unction
      --  - v2if - [V]isually select [I]nside 2nd next [F]unction
      --
      -- Treesitter textobjects - CLASS (c):
      --  - vic  - [V]isually select [I]nside [C]lass body
      --  - vac  - [V]isually select [A]round [C]lass (entire class)
      --  - dac  - [D]elete [A]round [C]lass
      --  - cic  - [C]hange [I]nside [C]lass body
      --  - vinc - [V]isually select [I]nside [N]ext [C]lass
      --
      -- Treesitter textobjects - PARAMETER (p):
      --  Note: operates on individual parameters, use vi( for all params
      --  - vip  - [V]isually select [I]nside [P]arameter (1st param)
      --  - vap  - [V]isually select [A]round [P]arameter (includes comma)
      --  - dap  - [D]elete [A]round [P]arameter (removes param + comma)
      --  - cip  - [C]hange [I]nside [P]arameter
      --  - v2ip - [V]isually select [I]nside 2nd [P]arameter
      --  - vinp - [V]isually select [I]nside [N]ext [P]arameter
      --  - vilp - [V]isually select [I]nside [L]ast/previous [P]arameter
      --
      -- Treesitter textobjects - CONDITIONAL/LOOP (o):
      --  - vio  - [V]isually select [I]nside if/for/while body
      --  - vao  - [V]isually select [A]round if/for/while (includes keyword)
      --  - dao  - [D]elete [A]round [O]conditional/loop
      --  - cio  - [C]hange [I]nside conditional/loop body
      --  - vino - [V]isually select [I]nside [N]ext conditional/loop
      --
      -- Note: For blocks, use built-in bracket textobjects instead:
      --  - ci{  - [C]hange [I]nside [{] (works better than treesitter)
      --  - da{  - [D]elete [A]round [{]
      --  - vi{  - [V]isually select [I]nside [{]
      local mini_ai = require 'mini.ai'
      local ts_spec = function(ai_captures)
        return mini_ai.gen_spec.treesitter(ai_captures, { use_nvim_treesitter = true })
      end

      mini_ai.setup {
        n_lines = 500,
        custom_textobjects = {
          -- Treesitter-based textobjects using nvim-treesitter for #make-range! support
          f = ts_spec { a = '@function.outer', i = '@function.inner' },
          c = ts_spec { a = '@class.outer', i = '@class.inner' },
          p = ts_spec { a = '@parameter.outer', i = '@parameter.inner' },
          o = ts_spec {
            a = { '@conditional.outer', '@loop.outer' },
            i = { '@conditional.inner', '@loop.inner' },
          },
        },
      }
    end,
  },

  -- Split and join arguments, array elements, etc.
  {
    'nvim-mini/mini.splitjoin',
    event = 'VeryLazy',
    opts = {},
  },

  -- Add/delete/replace surroundings (brackets, quotes, etc.)
  -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
  -- - sd'   - [S]urround [D]elete [']quotes
  -- - sr)'  - [S]urround [R]eplace [)] [']
  {
    'nvim-mini/mini.surround',
    event = 'VeryLazy',
    opts = {},
  },

  -- Pair matching () {} []
  {
    'nvim-mini/mini.pairs',
    event = 'VeryLazy',
    opts = {},
  },

  -- Commenting out code
  {
    'nvim-mini/mini.comment',
    event = 'VeryLazy',
    opts = {},
  },

  -- Highlight word under cursor
  {
    'nvim-mini/mini.cursorword',
    event = 'VeryLazy',
    opts = {},
  },

  -- Move lines in N and V mode
  {
    'nvim-mini/mini.move',
    event = 'VeryLazy',
    opts = {
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
    },
  },

  -- Icons for file types, LSP kinds, etc.
  {
    'nvim-mini/mini.icons',
    event = 'VeryLazy',
    config = function()
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
          -- Minuet AI completion kind
          minuet = { glyph = '󰚩', hl = 'MiniIconsPurple' },
        },
      }

      -- Mock nvim-web-devicons for plugins that depend on it
      -- Must be called after setup() per mini.icons docs
      local MiniIcons = require 'mini.icons'
      MiniIcons.mock_nvim_web_devicons()
      MiniIcons.tweak_lsp_kind()
    end,
  },
}
