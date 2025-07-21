return {
  {
    'mason-org/mason.nvim',
    opts = {
      ui = {
        border = 'rounded',
        icons = {
          ---@since 1.0.0
          -- The list icon to use for installed packages.
          package_installed = '',
          ---@since 1.0.0
          -- The list icon to use for packages that are installing, or queued for installation.
          package_pending = '◍',
          ---@since 1.0.0
          -- The list icon to use for packages that are not installed.
          package_uninstalled = '◍',
        },
      },
    },
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = {
      ensure_installed = {
        'vtsls',
        'gopls',
        'lua-language-server', -- Mason: lua-language-server -> lspconfig: lua_ls
        'json-lsp',
        'gofumpt',
        'goimports',
        'goimports-reviser',
        'gomodifytags',
        'impl',
        'delve',
        'eslint-lsp',
        'prettier',
        'stylua',
      },
    },
  },
}
