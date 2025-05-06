local set = vim.keymap.set

set('n', '<c-j>', '<c-w><c-j>')
set('n', '<c-k>', '<c-w><c-k>')
set('n', '<c-l>', '<c-w><c-l>')
set('n', '<c-h>', '<c-w><c-h>')

-- set('n', '<leader>x', '<cmd>.lua<CR>', { desc = 'Execute the current line' })
-- set('n', '<leader><leader>x', '<cmd>source %<CR>', { desc = 'Execute the current file' })

set('n', '<leader>w', '<cmd>silent! w<CR>', { desc = 'save current buffer' })
set('n', '<leader>q', '<cmd>q<cr>', { desc = 'close neovim' })
