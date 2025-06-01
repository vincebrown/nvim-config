return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bufdelete = { enabled = true },
    dim = { enabled = true },
    indent = { enabled = false },
    lazygit = { enabled = true, configure = true },
    scroll = { enabled = true },
    win = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 4000,
    },
    dashboard = {
      enabled = true,
    },
    zen = {
      enabled = true,
      toggles = {
        dim = false,
        indent = false,
        git_signs = false,
        mini_diff_signs = false,
      },
    },
  },
  keys = {
    {
      '<leader>gB',
      function()
        Snacks.gitbrowse()
      end,
      desc = 'Git Browse',
      mode = { 'n', 'v' },
    },
    {
      '<leader>z',
      function()
        Snacks.zen()
      end,
      desc = 'Toggle zen mode',
    },
    {
      '<leader>gg',
      function()
        Snacks.lazygit()
      end,
      desc = 'Lazygit',
    },
    {
      '<leader>bd',
      function()
        Snacks.bufdelete()
      end,
      desc = 'Delete Buffer',
    },
    {
      '<leader>ba',
      function()
        Snacks.bufdelete.all()
      end,
      desc = 'Buffer delete all',
      mode = 'n',
    },
    {
      '<leader>bo',
      function()
        Snacks.bufdelete.other()
      end,
      desc = 'Buffer delete other',
      mode = 'n',
    },
  },

  init = function()
    vim.api.nvim_create_autocmd('User', {
      pattern = 'VeryLazy',
      callback = function()
        Snacks.toggle.indent():map '<leader>ug'
        Snacks.toggle.dim():map '<leader>uD'
      end,
    })
  end,
}
