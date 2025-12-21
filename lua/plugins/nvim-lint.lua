return {
  {
    'mfussenegger/nvim-lint',
    event = { 'BufWritePost', 'BufReadPost', 'InsertLeave' },
    config = function()
      local lint = require 'lint'

      local function get_js_linters()
        -- Check for ESLint first (higher priority)
        if
          vim.fs.root(0, {
            '.eslintrc.js',
            '.eslintrc.cjs',
            '.eslintrc.yaml',
            '.eslintrc.yml',
            '.eslintrc.json',
            '.eslintrc',
            'eslint.config.js',
            'eslint.config.mjs',
            'eslint.config.cjs',
          })
        then
          return { 'eslint' }
        -- Then check for Biome
        elseif vim.fs.root(0, { 'biome.json', 'biome.jsonc' }) then
          return { 'biomejs' }
        end
        return {}
      end

      local js_linters = get_js_linters()

      lint.linters_by_ft = {
        javascript = js_linters,
        typescript = js_linters,
        javascriptreact = js_linters,
        typescriptreact = js_linters,
        ruby = { 'rubocop' },
      }

      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufReadPost', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          require('lint').try_lint()
        end,
      })

      vim.keymap.set('n', '<leader>cl', function()
        require('lint').try_lint()
      end, { desc = 'Lint current file' })
    end,
  },
}
