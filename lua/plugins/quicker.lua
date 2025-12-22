return {
  'stevearc/quicker.nvim',
  ft = 'qf',
  ---@module "quicker"
  ---@type quicker.SetupOptions
  opts = {},
  keys = {
    {
      '<leader>qf',
      function()
        require('quicker').toggle()
      end,
      desc = 'Toggle quickfix',
    },
  },
}
