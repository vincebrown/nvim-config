return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
    config = function()
      local harpoon = require 'harpoon'

      harpoon.setup {}

      local conf = require('telescope.config').values

      local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end

        require('telescope.pickers')
          .new({}, {
            prompt_title = 'Harpoon',
            finder = require('telescope.finders').new_table {
              results = file_paths,
            },
            previewer = conf.file_previewer {},
            sorter = conf.generic_sorter {},
          })
          :find()
      end

      vim.keymap.set('n', '<leader>ha', function()
        harpoon:list():add()
      end, { desc = '[H]arpoon [A]dd' })

      vim.keymap.set('n', '<leader>hr', function()
        harpoon:list():remove()
      end, { desc = '[H]arpoon [R]emove' })

      vim.keymap.set('n', '<leader>hq', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = '[H]arpoon [Q]uick Menu' })

      vim.keymap.set('n', '<leader>ht', function()
        toggle_telescope(harpoon:list())
      end, { desc = '[H]arpoon [T]elescope' })

      vim.keymap.set('n', '<leader>hj', function()
        harpoon:list():select(1)
      end, { desc = '[H]arpoon First Item' })

      vim.keymap.set('n', '<leader>hk', function()
        harpoon:list():select(2)
      end, { desc = '[H]arpoon Second Item' })

      vim.keymap.set('n', '<leader>hl', function()
        harpoon:list():select(3)
      end, { desc = '[H]arpoon Third Item' })

      vim.keymap.set('n', '<leader>h;', function()
        harpoon:list():select(4)
      end, { desc = '[H]arpoon Fourth Item' })

      harpoon:extend {
        UI_CREATE = function(cx)
          vim.keymap.set('n', '<C-v>', function()
            harpoon.ui:select_menu_item { vsplit = true }
          end, { buffer = cx.bufnr })
        end,
      }
    end,
  },
}
