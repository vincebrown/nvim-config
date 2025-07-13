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

      vim.keymap.set('n', '<leader>dbp', dap.toggle_breakpoint, { desc = 'Toggle breakpoint' })
      vim.keymap.set('n', '<leader>dra', dap.run_to_cursor, { desc = 'Run to cursor' })

      -- Eval var under cursor
      vim.keymap.set('n', '<leader>dbe', function()
        require('dapui').eval(nil, { enter = true })
      end, { desc = 'Evaluate expression' })

      vim.keymap.set('n', '<leader>dbc', dap.continue, { desc = 'Continue' })
      vim.keymap.set('n', '<leader>dsi', dap.step_into, { desc = 'Step into' })
      vim.keymap.set('n', '<leader>dso', dap.step_over, { desc = 'Step over' })
      vim.keymap.set('n', '<leader>dsO', dap.step_out, { desc = 'Step out' })
      vim.keymap.set('n', '<leader>dsb', dap.step_back, { desc = 'Step back' })
      vim.keymap.set('n', '<leader>dbr', dap.restart, { desc = 'Restart' })

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
