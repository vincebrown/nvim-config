return {
  'mrjones2014/smart-splits.nvim',
  opts = {
    ignored_filetypes = { 'nofile', 'quickfix', 'qf', 'prompt' },
    ignored_buftypes = { 'nofile' },
  },
  keys = {
    {
      '<C-S-h>',
      function()
        require('smart-splits').resize_left()
      end,
      desc = 'Resize left',
    },
    {
      '<C-S-j>',
      function()
        require('smart-splits').resize_down()
      end,
      desc = 'Resize down',
    },
    {
      '<C-S-k>',
      function()
        require('smart-splits').resize_up()
      end,
      desc = 'Resize up',
    },
    {
      '<C-S-l>',
      function()
        require('smart-splits').resize_right()
      end,
      desc = 'Resize right',
    },
  },
}
