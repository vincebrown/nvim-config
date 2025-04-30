-- Typescript specific plugins
return {
  {
    'pmizio/typescript-tools.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'neovim/nvim-lspconfig',
    },
    config = function()
      require('typescript-tools').setup {
        settings = {
          complete_function_calls = true,
          include_completions_with_insert_text = true,
          code_lens = 'implementations_only',
          expose_as_code_action = 'all',
          tsserver_file_preferences = {
            includeCompletionsForModuleExports = true,
            importModuleSpecifierPreference = 'non-relative',
            quotePreference = 'auto',
          },
        },
      }

      vim.keymap.set('n', '<leader>ci', '<cmd>TSToolsAddMissingImports<CR>', { desc = 'Add all missing imports' })
    end,
  },
}
