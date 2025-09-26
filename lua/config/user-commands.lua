--- Debug linters and formatters attached to current buffer
--- Displays information about configured linters and available formatters
--- for the current buffer's filetype via Snacks notification
local function lint_format_info()
  local ft = vim.bo.filetype
  local linters = require('lint').linters_by_ft[ft] or {}
  local formatters = require('conform').list_formatters(0)

  local linter_names = {}
  for _, linter in ipairs(linters) do
    table.insert(linter_names, linter)
  end

  local formatter_names = {}
  for _, formatter in ipairs(formatters) do
    table.insert(formatter_names, formatter.name)
  end

  local info = {}
  table.insert(info, '**Filetype:** ' .. ft)
  table.insert(info, '')

  if #linter_names > 0 then
    table.insert(info, '**Linters:** ' .. table.concat(linter_names, ', '))
  else
    table.insert(info, '**Linters:** None configured')
  end

  if #formatter_names > 0 then
    table.insert(info, '**Formatters:** ' .. table.concat(formatter_names, ', '))
  else
    table.insert(info, '**Formatters:** None available')
  end

  Snacks.notify.info(table.concat(info, '\n'), { title = 'Lint & Format Info' })
end

vim.api.nvim_create_user_command('LintFormatInfo', lint_format_info, { desc = 'Show linters and formatters for current buffer' })

--- Copy file path relative to project root to clipboard
--- If in a git repository, copies the file path relative to git root
--- Otherwise falls back to copying just the filename
--- Uses the '+' register (system clipboard)
local function yank_path()
  local path = vim.fn.expand '%:p'
  local git_root = vim.fn.systemlist('git rev-parse --show-toplevel')[1]

  if vim.v.shell_error == 0 and git_root then
    local relative_path = path:gsub('^' .. vim.pesc(git_root) .. '/', '')
    vim.fn.setreg('+', relative_path)
    Snacks.notify.info('Copied: ' .. relative_path, { title = 'File Path' })
  else
    -- Fallback to filename if not in git repo
    local filename = vim.fn.expand '%:t'
    vim.fn.setreg('+', filename)
    Snacks.notify.info('Copied: ' .. filename .. ' (not in git repo)', { title = 'File Path' })
  end
end

vim.api.nvim_create_user_command('YankPath', yank_path, { desc = 'Copy file path relative to git root to clipboard' })

--- Restart all LSP clients for a buffer
--- Stops all LSP clients attached to the buffer and re-edits the file
--- to trigger LSP reattachment
--- @param bufnr? number Buffer number (defaults to current buffer)
local function restart_lsp(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients { bufnr = bufnr }

  for _, client in ipairs(clients) do
    vim.lsp.stop_client(client.id)
  end

  vim.defer_fn(function()
    vim.cmd 'edit'
  end, 100)
end

vim.api.nvim_create_user_command('LspRestart', restart_lsp, { desc = 'Restart all LSP clients for current buffer' })

--- Display detailed LSP status information
--- Shows all LSP clients attached to current buffer including
--- client names, root directories, filetypes, and capabilities
--- Displays information via Snacks notification with extended timeout
local function lsp_status()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients { bufnr = bufnr }

  if #clients == 0 then
    Snacks.notify.info('󰅚 No LSP clients attached', {
      title = 'LSP Status',
      timeout = 5000, -- 5 seconds
    })
    return
  end

  local info = {}
  table.insert(info, '󰒋 **LSP Status for buffer ' .. bufnr .. ':**')
  table.insert(info, '')

  for i, client in ipairs(clients) do
    table.insert(info, string.format('󰌘 **Client %d:** %s (ID: %d)', i, client.name, client.id))
    table.insert(info, '  **Root:** ' .. (client.config.root_dir or 'N/A'))
    table.insert(info, '  **Filetypes:** ' .. table.concat(client.config.filetypes or {}, ', '))

    -- Check capabilities
    local caps = client.server_capabilities
    local features = {}
    if caps and caps.completionProvider then
      table.insert(features, 'completion')
    end
    if caps and caps.hoverProvider then
      table.insert(features, 'hover')
    end
    if caps and caps.definitionProvider then
      table.insert(features, 'definition')
    end
    if caps and caps.referencesProvider then
      table.insert(features, 'references')
    end
    if caps and caps.renameProvider then
      table.insert(features, 'rename')
    end
    if caps and caps.codeActionProvider then
      table.insert(features, 'code_action')
    end
    if caps and caps.documentFormattingProvider then
      table.insert(features, 'formatting')
    end

    table.insert(info, '  **Features:** ' .. table.concat(features, ', '))
    table.insert(info, '')
  end

  Snacks.notify.info(table.concat(info, '\n'), {
    title = 'LSP Status',
    timeout = 6000,
    style = {
      wo = {
        wrap = true,
        linebreak = true,
      },
    },
  })
end

vim.api.nvim_create_user_command('LspStatus', lsp_status, { desc = 'Show detailed LSP status' })

--- Reload Neovim configuration completely
--- Saves all modified buffers, clears Lua package cache for config modules,
--- and restarts Lazy with change detection to reload the configuration
--- Provides comprehensive configuration reload without restarting Neovim
local function reload_nvim_config()
  -- Save all modified buffers
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].modified then
      vim.api.nvim_buf_call(buf, function()
        vim.cmd 'write'
      end)
    end
  end

  -- Clear Lua package cache for config modules
  for name, _ in pairs(package.loaded) do
    if name:match '^config' or name:match '^plugins' or name:match '^lsp' or name:match '^core' then
      package.loaded[name] = nil
    end
  end

  -- Force Lazy's change detection to trigger a reload
  vim.api.nvim_exec_autocmds('User', { pattern = 'LazyReload' })

  Snacks.notify.info('Configuration reloaded successfully', { title = 'Reload Complete' })
end

vim.api.nvim_create_user_command('ReloadNvimConfig', reload_nvim_config, { desc = 'Reload Neovim Configuration' })
