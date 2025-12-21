return {
  {
    'stevearc/oil.nvim',
    dependencies = { { 'nvim-mini/mini.icons', opts = {} } },
    config = function()
      local function get_oil_winbar()
        local dir = require('oil').get_current_dir()
        if dir then
          return '  ' .. vim.fn.fnamemodify(dir, ':.')
        end
        return ''
      end

      require('oil').setup {
        columns = { 'icon' },
        keymaps = {
          ['<C-h>'] = false,
          ['<C-l>'] = false,
          ['<C-k>'] = false,
          ['<C-j>'] = false,
          ['<M-h>'] = 'actions.select_split',
          ['yp'] = {
            desc = 'Yank relative path',
            callback = function()
              local oil = require 'oil'
              local entry = oil.get_cursor_entry()
              if not entry or not entry.name then
                Snacks.notify.warn 'No entry found'
                return
              end

              local dir = oil.get_current_dir()
              local full_path = vim.fs.normalize(dir .. '/' .. entry.name)
              local relative_path = vim.fn.fnamemodify(full_path, ':.')

              vim.fn.setreg('+', relative_path)
              Snacks.notify.info('Yanked: ' .. relative_path)
            end,
          },
        },
        view_options = {
          show_hidden = true,
        },
      }

      -- Set winbar for oil buffers using autocommand
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'oil',
        callback = function()
          vim.opt_local.winbar = get_oil_winbar()
        end,
      })

      -- Open parent directory in current window
      vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })

      -- Open parent directory in floating window
      vim.keymap.set('n', '<leader>-', require('oil').toggle_float, { desc = 'Toggle oil' })
    end,
  },
}
