return {
  {
    'kndndrj/nvim-dbee',
    dependencies = { 'MunifTanjim/nui.nvim' },
    build = function()
      require('dbee').install()
    end,
    config = function()
      local source = require 'dbee.sources'
      require('dbee').setup {
        sources = {
          source.MemorySource:new {
            {
              id = 'db-1',
              type = 'postgres',
              name = 'TODO App',
              url = 'postgres://postgres:postgres@localhost:5432/todo_app?sslmode=disable',
            },
          },
          -- You can add more databases here
        },
      }
      -- Store the dbee module in a variable to avoid multiple requires
      local dbee = require 'dbee'
      local set = vim.keymap.set
      set('n', '<leader>do', function()
        dbee.open()
      end, { desc = 'Database open' })
      set('n', '<leader>dt', function()
        dbee.toggle()
      end, { desc = 'Database toggle' })
      set('n', '<leader>dc', function()
        dbee.close()
      end, { desc = 'Database close' })
    end,
  },
}
