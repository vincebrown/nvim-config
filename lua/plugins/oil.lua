return {
  {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      CustomOilBar = function()
        local path = vim.fn.expand '%'
        path = path:gsub('oil://', '')

        return '  ' .. vim.fn.fnamemodify(path, ':.')
      end

      require('oil').setup {
        columns = { 'icon' },
        keymaps = {
          ['<C-h>'] = false,
          ['<C-l>'] = false,
          ['<C-k>'] = false,
          ['<C-j>'] = false,
          ['<M-h>'] = 'actions.select_split',
          ['yp'] = function()
            local oil = require 'oil'
            local entry = oil.get_cursor_entry()
            if not entry or not entry.name then
              vim.notify('No entry found', vim.log.levels.WARN)
              return
            end

            local dir = oil.get_current_dir()
            local full_path = vim.fs.normalize(dir .. '/' .. entry.name)
            local cwd = vim.fn.getcwd()
            local relative_path = vim.fn.fnamemodify(full_path, ':.')

            vim.fn.setreg('+', relative_path)
            vim.notify('Yanked relative path: ' .. relative_path)
          end,
        },
        win_options = {
          winbar = '%{v:lua.CustomOilBar()}',
        },
        view_options = {
          show_hidden = true,
          is_always_hidden = function(name, _)
            local folder_skip = { 'dev-tools.locks', 'dune.lock', '_build' }
            return vim.tbl_contains(folder_skip, name)
          end,
        },
      }

      -- Open parent directory in current window
      vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })

      -- Open parent directory in floating window
      vim.keymap.set('n', '<space>-', require('oil').toggle_float)
    end,
  },
}
