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
set('n', '<leader>q', '<cmd>q<cr>', { desc = 'Quit' })

set('n', '<leader>/', 'gcc', { desc = 'Toggle comment', remap = true })
set('v', '<leader>/', 'gc', { desc = 'Toggle comment', remap = true })

-- Diagnostics
set('n', '<C-w><C-d>', function()
  vim.diagnostic.open_float { max_width = 70 }
end, { desc = 'Open diagnostic float' })

-- Configuration reload
set('n', '<leader>rr', function()
  -- Clear Lua package cache
  for name, _ in pairs(package.loaded) do
    if name:match '^config' or name:match '^plugins' then
      package.loaded[name] = nil
    end
  end

  -- Reload init.lua
  dofile(vim.env.MYVIMRC or (vim.fn.stdpath 'config' .. '/init.lua'))

  Snacks.notify.info 'Neovim configuration reloaded!'
end, { desc = 'Reload Neovim configuration' })
