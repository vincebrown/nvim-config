-- Debug Linters and formatters attached to current buffer
vim.api.nvim_create_user_command('LintFormatInfo', function()
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
end, {})

-- Copy file path relative to project root to clipboard
vim.api.nvim_create_user_command('YankPath', function()
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
end, {})

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

vim.api.nvim_create_user_command('LspRestart', function()
  restart_lsp()
end, {})

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
