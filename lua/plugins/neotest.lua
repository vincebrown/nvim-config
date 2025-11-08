return {
  {
    'nvim-neotest/neotest',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      'nvim-neotest/neotest-jest',
    },
    config = function()
      require('neotest').setup {
        summary = {
          open = 'botright vsplit | vertical resize 80',
        },
        discovery = {
          enabled = false,
        },
        status = { virtual_text = true },
        output = { open_on_run = true },
        quickfix = {
          open = function()
            if pcall(require, 'trouble') then
              require('trouble').open { mode = 'quickfix', focus = false }
            else
              vim.cmd 'copen'
            end
          end,
        },
        adapters = {
          require 'neotest-jest' {
            jestCommand = 'npm test --',
            cwd = function()
              return vim.fn.getcwd()
            end,
            jestArguments = function(defaultArguments)
              return defaultArguments
            end,
            jestTestDiscovery = false,
            isTestFile = require('neotest-jest.jest-util').defaultIsTestFile,
          },
        },
      }

      local neotest = require 'neotest'

      local map = vim.keymap.set
      map('n', '<leader>tt', function()
        neotest.run.run(vim.fn.expand '%')
      end, { desc = 'Run File (Neotest)' })

      map('n', '<leader>tn', function()
        neotest.run.run()
      end, { desc = 'Run Nearest (Neotest)' })

      map('n', '<leader>ts', function()
        neotest.summary.toggle()
      end, { desc = 'Toggle Summary (Neotest)' })

      map('n', '<leader>to', function()
        neotest.output.open { enter = true, auto_close = true }
      end, { desc = 'Show Output (Neotest)' })

      map('n', '<leader>tO', function()
        neotest.output_panel.toggle()
      end, { desc = 'Toggle Output Panel (Neotest)' })
    end,
  },
}
