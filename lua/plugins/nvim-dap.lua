return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'leoluz/nvim-dap-go',
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
      'nvim-neotest/nvim-nio',
      'williamboman/mason.nvim',
    },
    config = function()
      local dap = require 'dap'
      local ui = require 'dapui'

      require('dapui').setup()
      require('dap-go').setup()

      require('nvim-dap-virtual-text').setup {
        -- This just tries to mitigate the chance that I leak tokens here. Probably won't stop it from happening...
        display_callback = function(variable)
          local name = string.lower(variable.name)
          local value = string.lower(variable.value)
          if name:match 'secret' or name:match 'api' or value:match 'secret' or value:match 'api' then
            return '*****'
          end

          if #variable.value > 15 then
            return ' ' .. string.sub(variable.value, 1, 15) .. '... '
          end

          return ' ' .. variable.value
        end,
      }

      vim.keymap.set('n', '<space>dbp', dap.toggle_breakpoint)
      vim.keymap.set('n', '<space>dra', dap.run_to_cursor)

      -- Eval var under cursor
      vim.keymap.set('n', '<space>dbe', function()
        require('dapui').eval(nil, { enter = true })
      end)

      vim.keymap.set('n', '<space>dbc', dap.continue)
      vim.keymap.set('n', '<space>dsi', dap.step_into)
      vim.keymap.set('n', '<space>dso', dap.step_over)
      vim.keymap.set('n', '<space>dsO', dap.step_out)
      vim.keymap.set('n', '<space>dsb', dap.step_back)
      vim.keymap.set('n', '<space>dbr', dap.restart)

      dap.listeners.before.attach.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        ui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        ui.close()
      end
    end,
  },
}
