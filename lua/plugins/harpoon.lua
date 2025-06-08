return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require 'harpoon'

      harpoon.setup()

      local function get_harpoon_picker_data()
        local file_paths = {}
        for _, item in ipairs(harpoon:list().items) do
          table.insert(file_paths, {
            text = item.value,
            file = item.value,
          })
        end
        return file_paths
      end

      vim.keymap.set('n', '<leader>ha', function()
        harpoon:list():add()
      end, { desc = 'Harpoon add File' })

      vim.keymap.set('n', '<leader>hr', function()
        harpoon:list():remove()
      end, { desc = 'Harpoon remove File' })

      vim.keymap.set('n', '<leader>hc', function()
        harpoon:list():clear()
      end, { desc = 'Harpoon clear all' })

      vim.keymap.set('n', '<leader>hq', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = 'Harpoon quick menu' })

      vim.keymap.set('n', '<leader>hp', function()
        Snacks.picker {
          finder = get_harpoon_picker_data,
          title = 'Harpoon',
          focus = 'list',
          layout = {
            preset = 'select',
          },
        }
      end, { desc = 'Harpoon Picker' })

      vim.keymap.set('n', '<leader>hj', function()
        harpoon:list():select(1)
      end, { desc = 'Harpoon first item' })

      vim.keymap.set('n', '<leader>hk', function()
        harpoon:list():select(2)
      end, { desc = 'Harpoon second item' })

      vim.keymap.set('n', '<leader>hl', function()
        harpoon:list():select(3)
      end, { desc = 'Harpoon third item' })

      vim.keymap.set('n', '<leader>h;', function()
        harpoon:list():select(4)
      end, { desc = 'Harpoon fourth item' })

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
