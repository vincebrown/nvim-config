local utils = require 'core.utils'

return {
  cmd = { 'tailwindcss-language-server', '--stdio' },
  root_markers = {
    'vite.config.ts',
    'tailwind.config.js',
    'tailwind.config.cjs',
    'tailwind.config.mjs',
    'tailwind.config.ts',
    'postcss.config.js',
    'postcss.config.cjs',
    'postcss.config.mjs',
    'postcss.config.ts',
  },
  filetypes = {
    -- html
    'astro',
    'astro-markdown',
    'gohtml',
    'gohtmltmpl',
    'html',
    'markdown',
    'mdx',
    'mustache',
    -- css
    'css',
    'postcss',
    -- js
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
  },
  settings = {
    tailwindCSS = {
      validate = true,
      lint = {
        cssConflict = 'warning',
        invalidApply = 'error',
        invalidScreen = 'error',
        invalidVariant = 'error',
        invalidConfigPath = 'error',
        invalidTailwindDirective = 'error',
        recommendedVariantOrder = 'warning',
        suggestCanonicalClasses = 'ignore',
      },
      classAttributes = {
        'class',
        'className',
        'class:list',
        'classList',
        'ngClass',
      },
      includeLanguages = {
        eelixir = 'html-eex',
        eruby = 'erb',
        templ = 'html',
        htmlangular = 'html',
      },
    },
  },
  capabilities = utils.create_lsp_capabilities(),
}
