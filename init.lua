require 'core.lsp'

require 'config.keymaps'
require 'config.options'
require 'config.utils'
require 'config.autocommands'
require 'config.user-commands'

require 'core.lazy'

vim.g.charcoal_whisper_transparent = true
vim.g.fjord_transparent = true
vim.g.ember_transparent = true
vim.g.abyssal_transparent = true
vim.g.copper_canyon_transparent = true
vim.cmd.colorscheme 'nordic'
