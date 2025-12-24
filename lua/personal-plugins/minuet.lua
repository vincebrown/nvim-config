return {
  'milanglacier/minuet-ai.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    require('minuet').setup {
      provider = 'codestral',
      provider_options = {
        codestral = {
          optional = {
            max_tokens = 256,
            stop = { '\n\n' },
          },
        },
      },
    }
  end,
}
