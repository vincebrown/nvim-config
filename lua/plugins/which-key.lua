return {
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    config = function()
      local icons = require 'utils.icons'
      local which_key = require 'which-key'

      which_key.setup {
        icons = {
          breadcrumb = icons.breadCrumb,
          separator = icons.arrowRight,
          group = icons.plus,
        },
        window = {
          border = 'shadow',
          position = 'bottom',
          margin = { 1, 0, 1, 0 },
          padding = { 1, 2, 1, 2 },
          winblend = 0,
          zindex = 1000,
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
          s = 'Save Buffer',
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
          i = 'Add Missing imports',
          r = 'Rename Variable',
          t = {
            name = 'Trouble',
            t = 'Toggle',
            d = 'Document',
            w = 'Workspace',
          },
          u = 'Toggle Undo Tree',
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
