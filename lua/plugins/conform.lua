return {
  {
    'stevearc/conform.nvim',
    lazy = false,
    keys = {
      {
        '<leader>cf',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = 'Format Buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        local disable_filetypes = { c = true, cpp = true }
        local lsp_format = 'fallback'
        if disable_filetypes[vim.bo[bufnr].filetype] then
          lsp_format = 'never'
        end
        return {
          timeout_ms = 1500,
          lsp_format = lsp_format,
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { 'biome', 'biome-organize-imports', 'prettier' },
        typescript = { 'biome', 'biome-organize-imports', 'prettier' },
        javascriptreact = { 'biome', 'biome-organize-imports', 'prettier' },
        typescriptreact = { 'biome', 'biome-organize-imports', 'prettier' },
        graphql = { 'biome', 'prettier' },
        json = { 'biome', 'prettier' },
        ruby = { 'rubocop' },
        go = { 'goimports-reviser', 'gofumpt' },
      },
      -- only run biome or prettier if there are config files in project
      formatters = {
        biome = {
          condition = function(self, ctx)
            return vim.fs.root(ctx.dirname, { 'biome.json', 'biome.jsonc' })
          end,
        },
        ['biome-organize-imports'] = {
          condition = function(self, ctx)
            return vim.fs.root(ctx.dirname, { 'biome.json', 'biome.jsonc' })
          end,
        },
        prettier = {
          condition = function(self, ctx)
            return vim.fs.root(ctx.dirname, {
              '.prettierrc',
              '.prettierrc.json',
              '.prettierrc.yml',
              '.prettierrc.yaml',
              '.prettierrc.js',
              'prettier.config.js',
            })
          end,
        },
      },
    },
  },
}
