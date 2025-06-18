return {
  -- Highlight todo, notes, etc in comments
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local todo_comments = require 'todo-comments'

      todo_comments.setup {
        keywords = {
          FIX = {
            icon = ' ',
            color = 'error',
            alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE' },
          },
          TODO = { icon = ' ', color = 'info' },
          HACK = { icon = ' ', color = 'warning', alt = { 'DONT SKIP' } },
          WARN = { icon = ' ', color = 'warning', alt = { 'WARNING', 'XXX' } },
          PERF = { icon = ' ', alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' } },
          NOTE = { icon = ' ', color = 'hint', alt = { 'INFO', 'READ', 'COLORS' } },
          TEST = { icon = ' ', color = 'test', alt = { 'TESTING', 'PASSED', 'FAILED' } },
        },
      }

      vim.keymap.set('n', '<leader>st', function()
        Snacks.picker.todo_comments()
      end, { desc = 'Search TODO' })

      vim.keymap.set('n', '<leader>sT', function()
        Snacks.picker.todo_comments { keywords = { 'TODO', 'FIX', 'FIXME' } }
      end, { desc = 'Search TODO/FIX/FIXME' })
    end,
  },
}
