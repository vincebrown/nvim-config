local set = vim.keymap.set

set('n', '<C-h>', '<C-w>h', { desc = 'Switch window left' })
set('n', '<C-l>', '<C-w>l', { desc = 'Switch window right' })
set('n', '<C-j>', '<C-w>j', { desc = 'Switch window down' })
set('n', '<C-k>', '<C-w>k', { desc = 'Switch window up' })

set('n', '<leader>w', '<cmd>silent! w<CR>', { desc = 'Save current buffer' })
set('n', '<leader>q', '<cmd>q<cr>', { desc = 'Close neovim' })
