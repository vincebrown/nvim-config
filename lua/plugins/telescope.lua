return {
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      require('telescope').setup {
        defaults = {
          require('telescope.themes').get_ivy(),
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
          aerial = {
            col1_width = 4,
            col2_width = 30,
            format_symbol = function(symbol_path, filetype)
              if filetype == 'json' or filetype == 'yaml' then
                return table.concat(symbol_path, '.')
              else
                return symbol_path[#symbol_path]
              end
            end,
            show_columns = 'both',
          },
        },
        pickers = {
          find_files = require('telescope.themes').get_ivy {
            layout_config = {
              height = 30,
            },
          },
          oldfiles = require('telescope.themes').get_ivy {
            layout_config = {
              height = 30,
            },
          },
          colorscheme = {
            enable_preview = true,
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
      pcall(require('telescope').load_extension, 'aerial')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Search Files' })
      vim.keymap.set('n', '<leader>fr', function()
        require('telescope.builtin').oldfiles {
          cwd_only = true,
        }
      end, { desc = 'Search Recent Files (cwd only)' })
      vim.keymap.set('n', '<leader>fR', builtin.oldfiles, { desc = 'Search Recent Files' })
      vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = 'Search Git Files' })
      vim.keymap.set('n', '<leader>fc', builtin.colorscheme, { desc = 'Search Colorschemes' })
      vim.keymap.set('n', '<leader>sb', builtin.current_buffer_fuzzy_find, { desc = 'Search Current Buffer' })
      vim.keymap.set('n', '<leader>sc', ':Telescope aerial<CR>', { desc = 'Search file code' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = 'Search Telescope Builtin' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = 'Search Current Word' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Search By Grep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = 'Search Diagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = 'Search Resume picker' })
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Search Neovim Help' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = 'Search Keymaps' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = 'Search Open Buffers' })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = 'Grep Open Files' })

      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = 'Search Neovim Files' })
    end,
  },
}
