return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      { 'yavorski/lualine-macro-recording.nvim' },
    },
    config = function()
      -- Import Catppuccin color palette
      local colors = require('catppuccin.palettes').get_palette()

      -- Create custom transparent theme
      -- We only need to define sections we use (b, c, y) but need all modes
      local custom_theme = {
        normal = { b = { fg = colors.text, bg = 'NONE' }, c = { fg = colors.text, bg = 'NONE' } },
        insert = { b = { fg = colors.text, bg = 'NONE' }, c = { fg = colors.text, bg = 'NONE' } },
        visual = { b = { fg = colors.text, bg = 'NONE' }, c = { fg = colors.text, bg = 'NONE' } },
        replace = { b = { fg = colors.text, bg = 'NONE' }, c = { fg = colors.text, bg = 'NONE' } },
        command = { b = { fg = colors.text, bg = 'NONE' }, c = { fg = colors.text, bg = 'NONE' } },
        inactive = { b = { fg = colors.subtext0, bg = 'NONE' }, c = { fg = colors.subtext0, bg = 'NONE' } },
      }

      -- Mode colors - changes based on current mode
      local mode_colors = {
        n = colors.blue, -- Normal
        i = colors.green, -- Insert
        v = colors.mauve, -- Visual
        V = colors.mauve, -- V-Line
        c = colors.yellow, -- Command
        r = colors.red, -- Prompt
        ['!'] = colors.red, -- Shell
      }

      -- Component configuration table for easy customization
      local component_config = {
        -- Left side components
        branch = {
          icon = '',
          color = {
            fg = colors.mauve,
            gui = 'bold',
          },
        },
        diff = {
          symbols = {
            added = ' ',
            modified = ' ',
            removed = ' ',
          },
          diff_color = {
            added = { fg = colors.green },
            modified = { fg = colors.yellow },
            removed = { fg = colors.red },
          },
        },
        diagnostics = {
          symbols = {
            error = ' ',
            warn = ' ',
            info = ' ',
            hint = ' ',
          },
          diagnostics_color = {
            error = { fg = colors.red },
            warn = { fg = colors.yellow },
            info = { fg = colors.blue },
            hint = { fg = colors.teal },
          },
        },
        -- Right side components
        location = {
          icon = '',
          color = { fg = colors.flamingo },
        },
        filetype = {
          icon_only = false,
          color = { fg = colors.green },
        },
        mode = {
          -- Color function that changes based on mode
          color = function()
            local mode = vim.fn.mode()
            return { fg = mode_colors[mode] or colors.lavender, gui = 'bold' }
          end,
        },
      }

      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = custom_theme,
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = true,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          },
        },
        sections = {
          lualine_a = {},
          lualine_b = {
            { 'branch', icon = component_config.branch.icon, color = component_config.branch.color },
            { 'diff', symbols = component_config.diff.symbols, diff_color = component_config.diff.diff_color },
            {
              'diagnostics',
              sources = { 'nvim_diagnostic' },
              symbols = component_config.diagnostics.symbols,
              diagnostics_color = component_config.diagnostics.diagnostics_color,
            },
          },
          lualine_c = {},
          lualine_x = {},
          lualine_y = {
            { 'mode', color = component_config.mode.color },
            { 'location', icon = component_config.location.icon, color = component_config.location.color },
          },
          lualine_z = {},
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {},
      }
    end,
  },
}
