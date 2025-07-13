return {
  { -- highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'bufreadpre', 'bufnewfile' },
    dependencies = {
      'windwp/nvim-ts-autotag',
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup {
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = { 'ruby' },
        },
        indent = {
          enable = true,
          disable = { 'ruby' },
        },
        autotag = {
          enable = true,
        },
        ensure_installed = {
          'astro',
          'bash',
          'html',
          'lua',
          'luadoc',
          'luap',
          'markdown',
          'vim',
          'vimdoc',
          'json',
          'jsonc',
          'jsdoc',
          'javascript',
          'typescript',
          'regex',
          'toml',
          'tsx',
          'yaml',
          'css',
          'markdown',
          'markdown_inline',
          'graphql',
          'dockerfile',
          'gitignore',
          'go',
          'gomod',
          'gowork',
          'gosum',
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<C-space>',
            node_incremental = '<C-space>',
            score_incremental = false,
            node_decremental = '<bs>',
          },
        },
      }
    end,
  },
}
