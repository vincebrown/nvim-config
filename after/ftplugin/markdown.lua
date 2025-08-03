-- Set text width to 85 characters for automatic line breaking
vim.opt_local.textwidth = 85

-- Enable automatic text wrapping using textwidth
vim.opt_local.formatoptions:append 't'

-- Optional: Also enable comment wrapping if needed
-- vim.opt_local.formatoptions:append('c')

-- Set up undo to restore original settings when leaving markdown files
vim.b.undo_ftplugin = (vim.b.undo_ftplugin or '') .. (vim.b.undo_ftplugin and ' | ' or '') .. 'setlocal textwidth< formatoptions<'
