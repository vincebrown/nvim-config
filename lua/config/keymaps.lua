vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local set = vim.keymap.set

-- Window Navigation
set('n', '<C-h>', '<C-w>h', { desc = 'Switch window left' })
set('n', '<C-l>', '<C-w>l', { desc = 'Switch window right' })
set('n', '<C-j>', '<C-w>j', { desc = 'Switch window down' })
set('n', '<C-k>', '<C-w>k', { desc = 'Switch window up' })

-- Buffer Management
set('n', '<leader>w', '<cmd>silent! w<CR>', { desc = 'Write' })
set('n', '<leader>qq', '<cmd>q<cr>', { desc = 'Quit' })

-- Comments
set('n', '<leader>/', 'gcc', { desc = 'Toggle comment', remap = true })
set('v', '<leader>/', 'gc', { desc = 'Toggle comment', remap = true })

-- Diagnostics
set('n', '<C-w><C-d>', function()
  vim.diagnostic.open_float { max_width = 70 }
end, { desc = 'Open diagnostic float' })

set('n', ']d', function()
  vim.diagnostic.jump { count = 1, float = true }
end, { desc = 'Next Diagnostic' })

set('n', '[d', function()
  vim.diagnostic.jump { count = -1, float = true }
end, { desc = 'Previous Diagnostic' })

set('n', ']e', function()
  vim.diagnostic.jump { count = 1, severity = vim.diagnostic.severity.ERROR }
end, { desc = 'Next Error' })

set('n', '[e', function()
  vim.diagnostic.jump { count = -1, severity = vim.diagnostic.severity.ERROR }
end, { desc = 'Previous Error' })

-- Configuration reload
set('n', '<leader>rr', '<cmd>ReloadNvimConfig<cr>', { desc = 'Reload Neovim configuration' })

set('n', 'yp', '<cmd>YankPath<cr>', { desc = 'Yank Path' })
