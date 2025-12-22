return {
  'saghen/blink.cmp',
  dependencies = { 'rafamadriz/friendly-snippets', 'xzbdmw/colorful-menu.nvim', 'MahanRahmati/blink-nerdfont.nvim' },
  version = '1.*',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = 'super-tab',
      ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
      ['<C-space>'] = { 'show_documentation', 'hide_documentation', 'fallback' },
    },
    appearance = {
      nerd_font_variant = 'mono',
    },
    completion = {
      documentation = {
        auto_show = false,
        window = {
          max_width = 20,
          border = 'rounded',
        },
      },
      ghost_text = { enabled = true },
      menu = {
        min_width = 10,
        max_height = 10,
        border = 'rounded',
        draw = {
          -- We don't need label_description now because label and label_description are already
          -- combined together in label by colorful-menu.nvim.
          columns = { { 'kind_icon' }, { 'label', gap = 1 } },
          components = {
            kind_icon = {
              text = function(ctx)
                local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                return kind_icon
              end,
              -- (optional) use highlights from mini.icons
              highlight = function(ctx)
                local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                return hl
              end,
            },
            kind = {
              -- (optional) use highlights from mini.icons
              highlight = function(ctx)
                local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                return hl
              end,
            },
            label = {
              width = { fill = true, max = 20 },
              text = function(ctx)
                return require('colorful-menu').blink_components_text(ctx)
              end,
              highlight = function(ctx)
                return require('colorful-menu').blink_components_highlight(ctx)
              end,
            },
          },
        },
      },
    },
    signature = {
      enabled = true,
      window = {
        max_width = 100,
        border = 'rounded',
      },
    },
    cmdline = {
      enabled = true,
      completion = {
        list = { selection = { preselect = false } },
        menu = {
          auto_show = function(ctx)
            return vim.fn.getcmdtype() == ':'
          end,
        },
        ghost_text = { enabled = true },
      },
    },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
      per_filetype = {
        lua = { inherit_defaults = true, 'lazydev' },
      },
      providers = {
        lazydev = {
          name = 'LazyDev',
          module = 'lazydev.integrations.blink',
          score_offset = 100, -- prioritize lazydev completions
        },
      },
    },
    fuzzy = { implementation = 'prefer_rust_with_warning' },
  },

  opts_extend = { 'sources.default' },
}
