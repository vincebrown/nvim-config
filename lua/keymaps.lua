-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move focus to the left window', noremap = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move focus to the right window', noremap = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move focus to the lower window', noremap = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move focus to the upper window', noremap = true })


