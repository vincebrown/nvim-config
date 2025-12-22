return {
  'NickvanDyke/opencode.nvim',
  dependencies = {
    -- Recommended for `ask()` and `select()`.
    -- Required for `snacks` provider.
    ---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
    { 'folke/snacks.nvim' },
  },
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      -- Auto-detect opencode port (requires lsof)
      port = nil,

      -- Disable integrated provider since you use external tmux pane
      provider = {
        enabled = false,
      },

      -- Enable auto-reload of buffers edited by opencode
      events = {
        enabled = true,
        reload = true,
      },

      -- Customize ask() prompt appearance
      ask = {
        prompt = "Ask opencode: ",
        snacks = {
          icon = "󰚩 ",
        },
      },

      -- Add custom prompts here if needed
      -- prompts = {
      --   custom = { prompt = "Your custom prompt @this", submit = true },
      -- },
    }
  end,
  keys = {
    -- Ask OpenCode about current file/selection
    {
      '<leader>oa',
      function()
        require('opencode').ask('@this: ', { submit = true })
      end,
      mode = { 'n', 'x' },
      desc = 'OpenCode: Ask',
    },

    -- Open action menu to select OpenCode commands
    {
      '<leader>os',
      function()
        require('opencode').select()
      end,
      mode = { 'n', 'x' },
      desc = 'OpenCode: Select action',
    },

    -- Send range to OpenCode with vim motions (e.g., go3j, goip)
    {
      '<leader>og',
      function()
        return require('opencode').operator '@this '
      end,
      mode = { 'n', 'x' },
      expr = true,
      desc = 'OpenCode: Send range',
    },

    -- Send current line to OpenCode
    {
      '<leader>ol',
      function()
        return require('opencode').operator '@this ' .. '_'
      end,
      mode = 'n',
      expr = true,
      desc = 'OpenCode: Send line',
    },
  },
}
