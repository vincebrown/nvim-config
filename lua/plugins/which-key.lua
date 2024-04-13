return {
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    config = function() -- This is the function that runs, AFTER loading
      local which_key = require 'which-key'

      which_key.setup {
        icons = {
          breadcrumb = '»', -- symbol used in the command line area that shows your active key combo
          separator = '', -- symbol used between a key and it's label
          group = '+', -- symbol prepended to a group
        },
        window = {
          border = 'shadow', -- none, single, double, shadow
          position = 'bottom', -- bottom, top
          margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]. When between 0 and 1, will be treated as a percentage of the screen size.
          padding = { 1, 2, 1, 2 }, -- extra window padding [top, right, bottom, left]
          winblend = 0, -- value between 0-100 0 for fully opaque and 100 for fully transparent
          zindex = 1000, -- positive value to position WhichKey above other floating windows.
        },
        ignore_missing = true,
      }

      which_key.register {
        -- LSP
        ['g'] = {
          name = 'Goto',
          d = 'Goto Definition',
          D = 'Goto Declaration',
          r = 'Goto References',
          I = 'Goto Implementation',
          ['td'] = 'Goto Type Definition',
        },

        ['K'] = 'Hover Documentation',

        -- Buffers (Bufferline)
        ['<leader>b'] = {
          name = 'Buffers',
          p = 'Toggle Pin',
          P = 'Delete Non Pinned',
          o = 'Delete Other',
          r = 'Delete to the Right',
          l = 'Delete to the Left',
          b = 'Previous',
          n = 'Next',
        },

        -- CODE
        ['<leader>c'] = {
          name = 'Code',
          a = 'Action',
          f = 'Format Buffer',
          h = {
            name = 'Harpoon',
            a = 'Add Item',
            m = 'QuickMenu',
            r = 'Remove Item',
            t = 'Telescope',
            h = 'First Item',
            k = 'Second Item',
            l = 'Third Item',
            [';'] = 'Fourth Item',
          },
          r = 'Rename Variable',
          t = {
            name = 'Trouble',
            t = 'Toggle',
            d = 'Document',
            w = 'Workspace',
          },
          z = 'Zen Mode',
        },

        -- Explorer
        ['<leader>e'] = {
          name = 'Explorer',
          b = 'Buffers',
          e = 'Toggle',
          g = 'Git Status',
        },

        -- SEARCH
        ['<leader>s'] = {
          name = 'Search',
          c = 'Color Schemes',
          d = 'Diagnostics',
          f = 'Files',
          g = 'By Grep',
          h = 'Help',
          k = 'Keymaps',
          n = 'Neovim Config Files',
          r = 'Resume',
          s = 'Telescope',
          w = 'Current Word',
          ['.'] = 'Recent Files',
          ['/'] = 'Grep Open Files',
        },

        ['<leader>r'] = { name = 'Rename', _ = 'which_key_ignore' },
      }
    end,
  },
}
