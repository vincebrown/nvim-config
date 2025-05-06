vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Initialize Lazy
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field

vim.opt.rtp:prepend(lazypath)

if vim.g.vscode then
  require 'vscode-keymaps'
  require('lazy').setup {
    { import = 'vscode-plugins' },
  }
  -- VSCode extension
else
  require 'options'
  require 'keymaps'
  require 'autocommands'

  require('lazy').setup {
    { import = 'plugins' },
  }

  -- Set Colorscheme
  vim.cmd.colorscheme 'catppuccin-mocha'
end
