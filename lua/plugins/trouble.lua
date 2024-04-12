return {
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    signs = {
      error = '',
      warning = '',
      hint = '',
      information = '',
      other = '',
    },
  },
  config = function(_, opts)
    vim.keymap.set('n', '<leader>ctt', function()
      require('trouble').toggle()
    end)

    vim.keymap.set('n', '<leader>ctw', function()
      require('trouble').toggle 'workspace_diagnostics'
    end)

    vim.keymap.set('n', '<leader>ctd', function()
      require('trouble').toggle 'document_diagnostics'
    end)
    -- vim.keymap.set('n', '<leader>xq', function()
    --   require('trouble').toggle 'quickfix'
    -- end)
    -- vim.keymap.set('n', '<leader>xl', function()
    --   require('trouble').toggle 'loclist'
    -- end)
    -- vim.keymap.set('n', 'gR', function()
    --   require('trouble').toggle 'lsp_references'
    -- end)
    --
    require('trouble').setup(opts)
  end,
}
