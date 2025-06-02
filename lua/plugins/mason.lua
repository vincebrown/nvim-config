return {
  { "mason-org/mason.nvim", opts = {} },
  {
  'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = {
  ensure_installed = {
    'vtsls',
    'gopls', -- Mason: gopls -> lspconfig: gopls
    'lua-language-server', -- Mason: lua-language-server -> lspconfig: lua_ls
    'gofumpt',
    'goimports',
    'goimports-reviser',
    'delve',
    'eslint-lsp',
    'prettier',
    'stylua',
  },
    }
  }
}
-- return {
--   {
--     "mason-org/mason.nvim",
--     opts = {}
-- },
--   {
--   'WhoIsSethDaniel/mason-tool-installer.nvim',
--   ensure_installed = {
--     'vtsls',
--     'gopls', -- Mason: gopls -> lspconfig: gopls
--     'lua-language-server', -- Mason: lua-language-server -> lspconfig: lua_ls
--     'gofumpt',
--     'goimports',
--     'goimports-reviser',
--     'delve',
--     'eslint-lsp',
--     'prettier',
--     'stylua',
--   },
--   },
-- }
