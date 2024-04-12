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
          e = {
            name = 'Explorer',
            e = 'Toggle',
            b = 'Buffers',
            g = 'Git Status',
          },
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

        ['<leader>d'] = { name = 'Document', _ = 'which_key_ignore' },
        ['<leader>r'] = { name = 'Rename', _ = 'which_key_ignore' },
        ['<leader>w'] = { name = 'Workspace', _ = 'which_key_ignore' },
        ['<leader>h'] = { name = 'Harpoon', _ = 'which_key_ignore' },
        ['<leader>z'] = { name = 'Zen Mode', _ = 'which_key_ignore' },
      }
    end,
  },
}
