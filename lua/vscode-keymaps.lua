local vscode = require 'vscode'

vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Sync neovim and system clipboard
vim.opt.clipboard = 'unnamedplus'

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Workbench

vim.keymap.set({ 'n' }, '<C-h>', function()
  vscode.action 'workbench.action.focusLeftGroup'
end, { silent = true })

vim.keymap.set({ 'n' }, '<C-l>', function()
  vscode.action 'workbench.action.focusRightGroup'
end)

vim.keymap.set({ 'n' }, '<C-j>', function()
  vscode.action 'workbench.action.focusBelowGroup'
end)

vim.keymap.set({ 'n' }, '<C-k>', function()
  vscode.action 'workbench.action.focusAboveGroup'
end)

vim.keymap.set({ 'n' }, '<leader>p', function()
  vscode.action 'workbench.action.showCommands'
end)

vim.keymap.set({ 'n' }, '<leader>w', function()
  vscode.action 'workbench.action.files.save'
end)

vim.keymap.set({ 'n' }, '<leader>ff', function()
  vscode.action 'workbench.action.quickOpen'
end)
vim.keymap.set({ 'n' }, '<leader>fp', function()
  vscode.action 'workbench.action.openRecent'
end)

vim.keymap.set({ 'n' }, '<leader>e', function()
  vscode.action 'workbench.action.toggleSidebarVisibility'
end)

vim.keymap.set({ 'n' }, '<leader>br', function()
  vscode.action 'workbench.action.closeEditorsToTheRight'
end)

vim.keymap.set({ 'n' }, '<leader>bf', function()
  vscode.action 'workbench.action.closeEditorsToTheLeft'
end)

vim.keymap.set({ 'n' }, '<leader>ba', function()
  vscode.action 'workbench.action.closeOtherEditors'
end)

vim.keymap.set({ 'n' }, '<leader>zm', function()
  vscode.action 'workbench.action.toggleZenMode'
end)

vim.keymap.set({ 'n' }, '<leader>tf', function()
  vscode.action 'workbench.action.terminal.toggleTerminal'
end)

-- Editor

vim.keymap.set({ 'n' }, '<leader>cf', function()
  vscode.action 'editor.fold'
end)

vim.keymap.set({ 'n' }, '<leader>cF', function()
  vscode.action 'editor.unfold'
end)

vim.keymap.set({ 'n', 'x', 'i' }, '<C-d>', function()
  vscode.with_insert(function()
    vscode.action 'editor.action.addSelectionToNextFindMatch'
  end)
end)
