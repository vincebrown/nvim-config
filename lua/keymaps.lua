vim.keymap.set('n', '<c-h>', ':wincmd h<CR>', { desc = 'Move focus to the left window', noremap = true, expr = true })
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>', { desc = 'Move focus to the right window', noremap = true, expr = true })
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>', { desc = 'Move focus to the lower window', noremap = true, expr = true })
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>', { desc = 'Move focus to the upper window', noremap = true, expr = true })
