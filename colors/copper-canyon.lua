---@diagnostic disable: undefined-global
-- Copper Canyon - "Desert Sunset" Edition
-- Warm terracotta-tinted darks with canyon colors
-- Designed for focus, comfort, and elegance on transparent backgrounds.
-- Author: Vince Brown
-- License: MIT

--------------------------------------------------------------------------------
-- CONFIGURATION
--------------------------------------------------------------------------------

local config = {
  transparent = vim.g.copper_canyon_transparent or false,
}

--------------------------------------------------------------------------------
-- COLOR PALETTE
-- "Desert Sunset" Palette: Warm terracotta with canyon hues
--------------------------------------------------------------------------------

local colors = {
  -- The Foundation (Warm Brown Backgrounds)
  black = '#1f1d1a',
  bg_dark = '#1a1816',
  bg_mid = '#262320',
  bg_light = '#2d2a26',
  bg_highlight = '#343029',
  bg_accent = '#3d3832',

  -- The Foregrounds (Sandstone Tones)
  fg_bright = '#e8dcc8',
  fg_normal = '#d4c4a9',
  fg_muted = '#a89880',

  -- The Accents (Canyon Colors)
  copper = '#e6a96d',
  sage = '#8fb573',
  turquoise = '#7ec4a5',
  terracotta = '#d4927a',
  gold = '#d4b86a',

  -- Punctuation & Structure
  stone = '#6b6358',
  graphite = '#4a453d',

  -- Functional Colors
  error_soft = '#c97070',
  warn_soft = '#d4a86a',
  success_soft = '#8fb573',
}

--------------------------------------------------------------------------------
-- SEMANTIC PALETTE
--------------------------------------------------------------------------------

local function get_palette()
  local transparent = config.transparent
  local none = 'NONE'

  return {
    bg = transparent and none or colors.black,
    bg_float = transparent and none or colors.bg_dark,
    bg_cursor = transparent and colors.bg_mid or colors.bg_mid,
    bg_statusline = transparent and colors.bg_light or colors.bg_light,
    bg_visual = colors.bg_highlight,
    bg_search = colors.bg_accent,
    bg_solid = colors.black,
    bg_float_solid = colors.bg_dark,

    fg = colors.fg_normal,
    fg_dim = colors.stone,
    fg_inactive = colors.graphite,

    bg_diff_add = '#232a1e',
    bg_diff_change = '#2a261e',
    bg_diff_delete = '#2a1e1e',
    bg_diff_text = '#3a3228',

    keyword = colors.copper,
    func = colors.sage,
    string = colors.turquoise,
    constant = colors.gold,
    type = colors.terracotta,
    variable = colors.fg_normal,
    property = colors.fg_normal,
    operator = colors.graphite,
    comment = colors.stone,
    punctuation = colors.graphite,
    tag = colors.copper,
    attribute = colors.gold,

    error = colors.error_soft,
    warning = colors.warn_soft,
    info = colors.turquoise,
    hint = colors.stone,
    success = colors.success_soft,

    git_add = colors.success_soft,
    git_change = colors.turquoise,
    git_delete = colors.error_soft,

    match = colors.sage,
    link = colors.turquoise,
    white = colors.fg_bright,
    steel = colors.copper,

    none = none,
  }
end

--------------------------------------------------------------------------------
-- HIGHLIGHT HELPER
--------------------------------------------------------------------------------

local function hl(fg, bg, opts)
  local h = { fg = fg, bg = bg }
  if opts then
    for k, v in pairs(opts) do h[k] = v end
  end
  return h
end

--------------------------------------------------------------------------------
-- HIGHLIGHT GROUPS
--------------------------------------------------------------------------------

local function generate_highlights(p)
  return {
    Normal = hl(p.fg, p.bg),
    NormalFloat = hl(p.fg, p.bg_float),
    NormalNC = hl(p.fg, p.bg),
    FloatBorder = hl(p.fg_inactive, p.bg_float),
    FloatTitle = hl(p.white, p.bg_float, { bold = true }),
    Cursor = hl(p.none, p.none, { reverse = true }),
    CursorLine = hl(p.none, p.bg_cursor),
    CursorColumn = hl(p.none, p.bg_cursor),
    CursorLineNr = hl(p.white, p.none, { bold = true }),
    LineNr = hl(p.fg_dim, p.none),
    SignColumn = hl(p.fg, p.none),
    FoldColumn = hl(p.fg_dim, p.none),
    Folded = hl(p.fg_inactive, p.bg_cursor),
    VertSplit = hl(p.bg_visual, p.none),
    WinSeparator = hl(p.bg_visual, p.none),
    ColorColumn = hl(p.none, p.bg_cursor),
    Visual = hl(p.none, p.bg_visual),
    VisualNOS = hl(p.none, p.bg_visual),

    Pmenu = hl(p.fg, p.bg_float_solid),
    PmenuSel = hl(p.bg_solid, p.white, { bold = true }),
    PmenuSbar = hl(p.none, p.bg_float_solid),
    PmenuThumb = hl(p.none, p.fg_inactive),

    Search = hl(p.bg_solid, p.match),
    IncSearch = hl(p.bg_solid, p.white),
    CurSearch = hl(p.bg_solid, p.white),
    Substitute = hl(p.bg_solid, p.error),
    MatchParen = hl(p.white, p.bg_search, { bold = true }),

    StatusLine = hl(p.fg, p.bg_statusline),
    StatusLineNC = hl(p.fg_dim, p.bg_cursor),
    TabLine = hl(p.fg_dim, p.bg_cursor),
    TabLineFill = hl(p.fg_dim, p.bg),
    TabLineSel = hl(p.fg, p.bg_statusline),
    WinBar = hl(p.fg, p.bg_statusline),
    WinBarNC = hl(p.fg_dim, p.bg_cursor),

    ModeMsg = hl(p.white, p.none, { bold = true }),
    MoreMsg = hl(p.success, p.none, { bold = true }),
    WarningMsg = hl(p.warning, p.none, { bold = true }),
    ErrorMsg = hl(p.error, p.none, { bold = true }),
    Question = hl(p.warning, p.none),
    Title = hl(p.white, p.none, { bold = true }),

    DiffAdd = hl(p.none, p.bg_diff_add),
    DiffChange = hl(p.none, p.bg_diff_change),
    DiffDelete = hl(p.none, p.bg_diff_delete),
    DiffText = hl(p.fg, p.bg_diff_text),
    Added = hl(p.git_add, p.none),
    Changed = hl(p.git_change, p.none),
    Removed = hl(p.git_delete, p.none),

    SpellBad = hl(p.none, p.none, { undercurl = true, sp = p.error }),
    SpellCap = hl(p.none, p.none, { undercurl = true, sp = p.info }),
    SpellLocal = hl(p.none, p.none, { undercurl = true, sp = p.info }),
    SpellRare = hl(p.none, p.none, { undercurl = true, sp = p.hint }),

    NonText = hl(p.bg_visual, p.none),
    EndOfBuffer = hl(p.bg, p.none),
    Whitespace = hl(p.bg_visual, p.none),
    SpecialKey = hl(p.bg_search, p.none),
    Conceal = hl(p.fg_dim, p.none),
    Directory = hl(p.white, p.none),

    DiagnosticError = hl(p.error, p.none),
    DiagnosticWarn = hl(p.warning, p.none),
    DiagnosticInfo = hl(p.info, p.none),
    DiagnosticHint = hl(p.hint, p.none),
    DiagnosticOk = hl(p.success, p.none),
    DiagnosticUnderlineError = hl(p.none, p.none, { undercurl = true, sp = p.error }),
    DiagnosticUnderlineWarn = hl(p.none, p.none, { undercurl = true, sp = p.warning }),
    DiagnosticUnderlineInfo = hl(p.none, p.none, { undercurl = true, sp = p.info }),
    DiagnosticUnderlineHint = hl(p.none, p.none, { undercurl = true, sp = p.hint }),
    DiagnosticUnderlineOk = hl(p.none, p.none, { undercurl = true, sp = p.success }),
    DiagnosticVirtualTextError = hl(p.error, p.bg_cursor),
    DiagnosticVirtualTextWarn = hl(p.warning, p.bg_cursor),
    DiagnosticVirtualTextInfo = hl(p.info, p.bg_cursor),
    DiagnosticVirtualTextHint = hl(p.hint, p.bg_cursor),
    DiagnosticVirtualTextOk = hl(p.success, p.bg_cursor),
    DiagnosticSignError = hl(p.error, p.none),
    DiagnosticSignWarn = hl(p.warning, p.none),
    DiagnosticSignInfo = hl(p.info, p.none),
    DiagnosticSignHint = hl(p.hint, p.none),
    DiagnosticSignOk = hl(p.success, p.none),

    Comment = hl(p.comment, p.none),
    Constant = hl(p.constant, p.none),
    String = hl(p.string, p.none),
    Character = hl(p.string, p.none),
    Number = hl(p.constant, p.none),
    Boolean = hl(p.constant, p.none),
    Float = hl(p.constant, p.none),
    Identifier = hl(p.variable, p.none),
    Function = hl(p.func, p.none, { bold = true }),
    Statement = hl(p.keyword, p.none, { bold = true }),
    Conditional = hl(p.keyword, p.none, { bold = true }),
    Repeat = hl(p.keyword, p.none, { bold = true }),
    Label = hl(p.keyword, p.none),
    Operator = hl(p.operator, p.none),
    Keyword = hl(p.keyword, p.none, { bold = true }),
    Exception = hl(p.error, p.none),
    PreProc = hl(p.type, p.none),
    Include = hl(p.keyword, p.none),
    Define = hl(p.type, p.none),
    Macro = hl(p.type, p.none),
    PreCondit = hl(p.type, p.none),
    Type = hl(p.type, p.none),
    StorageClass = hl(p.keyword, p.none),
    Structure = hl(p.type, p.none),
    Typedef = hl(p.type, p.none),
    Special = hl(p.white, p.none),
    SpecialChar = hl(p.white, p.none),
    Tag = hl(p.tag, p.none),
    Delimiter = hl(p.punctuation, p.none),
    SpecialComment = hl(p.comment, p.none, { bold = true }),
    Debug = hl(p.warning, p.none),
    Underlined = hl(p.link, p.none, { underline = true }),
    Ignore = hl(p.fg_dim, p.none),
    Error = hl(p.error, p.none),
    Todo = hl(p.bg_solid, p.warning, { bold = true }),

    ['@variable'] = hl(p.fg, p.none),
    ['@variable.builtin'] = hl(p.white, p.none),
    ['@variable.parameter'] = hl(p.fg, p.none),
    ['@variable.member'] = hl(p.property, p.none),
    ['@constant'] = hl(p.constant, p.none),
    ['@constant.builtin'] = hl(p.constant, p.none),
    ['@constant.macro'] = hl(p.constant, p.none),
    ['@module'] = hl(p.white, p.none),
    ['@module.builtin'] = hl(p.white, p.none),
    ['@namespace'] = { link = '@module' },
    ['@string'] = hl(p.string, p.none),
    ['@string.documentation'] = hl(p.string, p.none),
    ['@string.regex'] = hl(p.string, p.none),
    ['@string.regexp'] = hl(p.string, p.none),
    ['@string.escape'] = hl(p.white, p.none),
    ['@string.special'] = hl(p.white, p.none),
    ['@string.special.symbol'] = hl(p.white, p.none),
    ['@string.special.url'] = hl(p.link, p.none, { underline = true }),
    ['@character'] = hl(p.string, p.none),
    ['@character.special'] = hl(p.white, p.none),
    ['@number'] = hl(p.constant, p.none),
    ['@number.float'] = hl(p.constant, p.none),
    ['@boolean'] = hl(p.constant, p.none),
    ['@type'] = hl(p.type, p.none),
    ['@type.builtin'] = hl(p.type, p.none),
    ['@type.definition'] = hl(p.type, p.none),
    ['@type.qualifier'] = hl(p.keyword, p.none),
    ['@attribute'] = hl(p.attribute, p.none),
    ['@attribute.builtin'] = hl(p.attribute, p.none),
    ['@property'] = hl(p.property, p.none),
    ['@function'] = hl(p.func, p.none),
    ['@function.builtin'] = hl(p.func, p.none),
    ['@function.call'] = hl(p.func, p.none),
    ['@function.macro'] = hl(p.func, p.none),
    ['@function.method'] = hl(p.func, p.none),
    ['@function.method.call'] = hl(p.func, p.none),
    ['@method'] = hl(p.func, p.none),
    ['@method.call'] = hl(p.func, p.none),
    ['@constructor'] = hl(p.type, p.none),
    ['@operator'] = hl(p.operator, p.none),
    ['@keyword'] = hl(p.keyword, p.none),
    ['@keyword.conditional'] = hl(p.keyword, p.none),
    ['@keyword.conditional.ternary'] = hl(p.operator, p.none),
    ['@keyword.coroutine'] = hl(p.keyword, p.none),
    ['@keyword.debug'] = hl(p.warning, p.none),
    ['@keyword.directive'] = hl(p.type, p.none),
    ['@keyword.directive.define'] = hl(p.type, p.none),
    ['@keyword.exception'] = hl(p.error, p.none),
    ['@keyword.function'] = hl(p.keyword, p.none),
    ['@keyword.import'] = hl(p.keyword, p.none),
    ['@keyword.modifier'] = hl(p.keyword, p.none),
    ['@keyword.operator'] = hl(p.keyword, p.none),
    ['@keyword.repeat'] = hl(p.keyword, p.none),
    ['@keyword.return'] = hl(p.keyword, p.none),
    ['@keyword.storage'] = hl(p.keyword, p.none),
    ['@keyword.type'] = hl(p.keyword, p.none),
    ['@punctuation.bracket'] = hl(p.punctuation, p.none),
    ['@punctuation.delimiter'] = hl(p.punctuation, p.none),
    ['@punctuation.special'] = hl(p.white, p.none),
    ['@comment'] = hl(p.comment, p.none),
    ['@comment.documentation'] = hl(p.comment, p.none),
    ['@comment.error'] = hl(p.bg_solid, p.error, { bold = true }),
    ['@comment.warning'] = hl(p.bg_solid, p.warning, { bold = true }),
    ['@comment.note'] = hl(p.bg_solid, p.info, { bold = true }),
    ['@comment.todo'] = hl(p.bg_solid, p.warning, { bold = true }),
    ['@markup.strong'] = hl(p.none, p.none, { bold = true }),
    ['@markup.italic'] = hl(p.none, p.none, { italic = true }),
    ['@markup.strikethrough'] = hl(p.none, p.none, { strikethrough = true }),
    ['@markup.underline'] = hl(p.none, p.none, { underline = true }),
    ['@markup.heading'] = hl(p.white, p.none, { bold = true }),
    ['@markup.heading.1'] = hl(p.white, p.none, { bold = true }),
    ['@markup.heading.2'] = hl(p.white, p.none, { bold = true }),
    ['@markup.heading.3'] = hl(p.white, p.none, { bold = true }),
    ['@markup.heading.4'] = hl(p.white, p.none, { bold = true }),
    ['@markup.heading.5'] = hl(p.white, p.none, { bold = true }),
    ['@markup.heading.6'] = hl(p.white, p.none, { bold = true }),
    ['@markup.quote'] = hl(p.fg_inactive, p.none),
    ['@markup.math'] = hl(p.white, p.none),
    ['@markup.link'] = hl(p.link, p.none),
    ['@markup.link.label'] = hl(p.white, p.none),
    ['@markup.link.url'] = hl(p.link, p.none, { underline = true }),
    ['@markup.raw'] = hl(p.string, p.none),
    ['@markup.raw.block'] = hl(p.string, p.none),
    ['@markup.list'] = hl(p.white, p.none),
    ['@markup.list.checked'] = hl(p.success, p.none),
    ['@markup.list.unchecked'] = hl(p.fg_inactive, p.none),
    ['@tag'] = hl(p.tag, p.none, { bold = true }),
    ['@tag.attribute'] = hl(p.attribute, p.none),
    ['@tag.builtin'] = hl(p.tag, p.none, { bold = true }),
    ['@tag.delimiter'] = hl(p.punctuation, p.none),
    ['@none'] = hl(p.fg, p.none),

    ['@lsp.type.boolean'] = { link = '@boolean' },
    ['@lsp.type.builtinType'] = { link = '@type.builtin' },
    ['@lsp.type.class'] = { link = '@type' },
    ['@lsp.type.comment'] = { link = '@comment' },
    ['@lsp.type.decorator'] = { link = '@attribute' },
    ['@lsp.type.enum'] = { link = '@type' },
    ['@lsp.type.enumMember'] = { link = '@constant' },
    ['@lsp.type.escapeSequence'] = { link = '@string.escape' },
    ['@lsp.type.formatSpecifier'] = { link = '@punctuation.special' },
    ['@lsp.type.function'] = { link = '@function' },
    ['@lsp.type.interface'] = { link = '@type' },
    ['@lsp.type.keyword'] = { link = '@keyword' },
    ['@lsp.type.method'] = { link = '@function.method' },
    ['@lsp.type.namespace'] = { link = '@module' },
    ['@lsp.type.number'] = { link = '@number' },
    ['@lsp.type.operator'] = { link = '@operator' },
    ['@lsp.type.parameter'] = { link = '@variable.parameter' },
    ['@lsp.type.property'] = { link = '@property' },
    ['@lsp.type.selfKeyword'] = { link = '@variable.builtin' },
    ['@lsp.type.string'] = { link = '@string' },
    ['@lsp.type.struct'] = { link = '@type' },
    ['@lsp.type.type'] = { link = '@type' },
    ['@lsp.type.typeAlias'] = { link = '@type.definition' },
    ['@lsp.type.typeParameter'] = { link = '@type' },
    ['@lsp.type.variable'] = { link = '@variable' },

    ['@keyword.import.go'] = hl(p.keyword, p.none),
    ['@module.go'] = hl(p.fg, p.none),
    ['@constant.builtin.go'] = hl(p.white, p.none),
    ['@keyword.import.javascript'] = hl(p.keyword, p.none),
    ['@keyword.import.typescript'] = hl(p.keyword, p.none),
    ['@keyword.import.tsx'] = hl(p.keyword, p.none),
    ['@constructor.tsx'] = { link = '@type' },
    ['@constructor.lua'] = hl(p.punctuation, p.none),
    ['@label.json'] = hl(p.property, p.none),
    ['@string.json'] = hl(p.string, p.none),
    ['@variable.member.yaml'] = hl(p.property, p.none),
    ['@string.yaml'] = hl(p.string, p.none),

    BlinkCmpMenu = hl(p.fg, p.bg_float_solid),
    BlinkCmpMenuBorder = hl(p.fg_inactive, p.bg_float_solid),
    BlinkCmpMenuSelection = hl(p.none, p.bg_visual),
    BlinkCmpScrollBarThumb = hl(p.fg_inactive, p.none),
    BlinkCmpScrollBarGutter = hl(p.bg_float_solid, p.none),
    BlinkCmpLabel = hl(p.fg, p.none),
    BlinkCmpLabelDeprecated = hl(p.fg_dim, p.none, { strikethrough = true }),
    BlinkCmpLabelMatch = hl(p.match, p.none, { bold = true }),
    BlinkCmpDoc = hl(p.fg, p.bg_float_solid),
    BlinkCmpDocBorder = hl(p.fg_inactive, p.bg_float_solid),
    BlinkCmpDocSeparator = hl(p.fg_inactive, p.bg_float_solid),
    BlinkCmpSignatureHelp = hl(p.fg, p.bg_float_solid),
    BlinkCmpSignatureHelpBorder = hl(p.fg_inactive, p.bg_float_solid),
    BlinkCmpSignatureHelpActiveParameter = hl(p.match, p.none, { bold = true }),
    BlinkCmpGhostText = hl(p.fg_dim, p.none),
    BlinkCmpKindArray = hl(p.white, p.none),
    BlinkCmpKindBoolean = hl(p.white, p.none),
    BlinkCmpKindClass = hl(p.type, p.none),
    BlinkCmpKindColor = hl(p.white, p.none),
    BlinkCmpKindConstant = hl(p.white, p.none),
    BlinkCmpKindConstructor = hl(p.type, p.none),
    BlinkCmpKindEnum = hl(p.type, p.none),
    BlinkCmpKindEnumMember = hl(p.white, p.none),
    BlinkCmpKindEvent = hl(p.white, p.none),
    BlinkCmpKindField = hl(p.property, p.none),
    BlinkCmpKindFile = hl(p.string, p.none),
    BlinkCmpKindFolder = hl(p.property, p.none),
    BlinkCmpKindFunction = hl(p.func, p.none),
    BlinkCmpKindInterface = hl(p.type, p.none),
    BlinkCmpKindKey = hl(p.property, p.none),
    BlinkCmpKindKeyword = hl(p.keyword, p.none),
    BlinkCmpKindMethod = hl(p.func, p.none),
    BlinkCmpKindModule = hl(p.white, p.none),
    BlinkCmpKindNamespace = hl(p.white, p.none),
    BlinkCmpKindNull = hl(p.fg_inactive, p.none),
    BlinkCmpKindNumber = hl(p.white, p.none),
    BlinkCmpKindObject = hl(p.type, p.none),
    BlinkCmpKindOperator = hl(p.operator, p.none),
    BlinkCmpKindPackage = hl(p.white, p.none),
    BlinkCmpKindProperty = hl(p.property, p.none),
    BlinkCmpKindReference = hl(p.white, p.none),
    BlinkCmpKindSnippet = hl(p.steel, p.none),
    BlinkCmpKindString = hl(p.string, p.none),
    BlinkCmpKindStruct = hl(p.type, p.none),
    BlinkCmpKindText = hl(p.fg, p.none),
    BlinkCmpKindTypeParameter = hl(p.type, p.none),
    BlinkCmpKindUnit = hl(p.white, p.none),
    BlinkCmpKindValue = hl(p.white, p.none),
    BlinkCmpKindVariable = hl(p.variable, p.none),

    SnacksNormal = hl(p.fg, p.bg_float),
    SnacksDashboardNormal = hl(p.fg, p.bg),
    SnacksDashboardDesc = hl(p.fg_dim, p.none),
    SnacksDashboardFile = hl(p.string, p.none),
    SnacksDashboardDir = hl(p.fg_dim, p.none),
    SnacksDashboardFooter = hl(p.fg_dim, p.none, { italic = true }),
    SnacksDashboardHeader = hl(p.steel, p.none),
    SnacksDashboardIcon = hl(p.white, p.none),
    SnacksDashboardKey = hl(p.white, p.none),
    SnacksDashboardSpecial = hl(p.type, p.none),
    SnacksDashboardTitle = hl(p.steel, p.none, { bold = true }),
    SnacksNotifierInfo = hl(p.info, p.none),
    SnacksNotifierWarn = hl(p.warning, p.none),
    SnacksNotifierError = hl(p.error, p.none),
    SnacksNotifierDebug = hl(p.fg_dim, p.none),
    SnacksNotifierTrace = hl(p.white, p.none),
    SnacksNotifierIconInfo = hl(p.info, p.none),
    SnacksNotifierIconWarn = hl(p.warning, p.none),
    SnacksNotifierIconError = hl(p.error, p.none),
    SnacksNotifierIconDebug = hl(p.fg_dim, p.none),
    SnacksNotifierIconTrace = hl(p.white, p.none),
    SnacksNotifierTitleInfo = hl(p.info, p.none, { bold = true }),
    SnacksNotifierTitleWarn = hl(p.warning, p.none, { bold = true }),
    SnacksNotifierTitleError = hl(p.error, p.none, { bold = true }),
    SnacksNotifierTitleDebug = hl(p.fg_dim, p.none, { bold = true }),
    SnacksNotifierTitleTrace = hl(p.white, p.none, { bold = true }),
    SnacksIndent = hl(p.bg_visual, p.none),
    SnacksIndentScope = hl(p.fg_dim, p.none),
    SnacksZen = hl(p.fg, p.bg),
    SnacksPickerNormal = hl(p.fg, p.bg_float),
    SnacksPickerBorder = hl(p.fg_inactive, p.bg_float),
    SnacksPickerTitle = hl(p.steel, p.bg_float, { bold = true }),
    SnacksPickerPrompt = hl(p.white, p.none),
    SnacksPickerMatch = hl(p.match, p.none, { bold = true }),
    SnacksPickerSelected = hl(p.none, p.bg_visual),
    SnacksPickerPreview = hl(p.fg, p.bg_float),
    SnacksPickerPreviewBorder = hl(p.fg_inactive, p.bg_float),
    SnacksPickerPreviewTitle = hl(p.steel, p.bg_float, { bold = true }),
    SnacksExplorerNormal = hl(p.fg, p.bg_float),

    GitSignsAdd = hl(p.git_add, p.none),
    GitSignsChange = hl(p.git_change, p.none),
    GitSignsDelete = hl(p.git_delete, p.none),
    GitSignsAddNr = hl(p.git_add, p.none),
    GitSignsChangeNr = hl(p.git_change, p.none),
    GitSignsDeleteNr = hl(p.git_delete, p.none),
    GitSignsAddLn = hl(p.none, p.bg_diff_add),
    GitSignsChangeLn = hl(p.none, p.bg_diff_change),
    GitSignsDeleteLn = hl(p.none, p.bg_diff_delete),
    GitSignsCurrentLineBlame = hl(p.fg_dim, p.none, { italic = true }),

    TroubleNormal = hl(p.fg, p.bg_float),
    TroubleNormalNC = hl(p.fg, p.bg_float),
    TroubleCount = hl(p.steel, p.none),
    TroubleText = hl(p.fg, p.none),

    WhichKey = hl(p.steel, p.none),
    WhichKeyGroup = hl(p.white, p.none),
    WhichKeyDesc = hl(p.fg, p.none),
    WhichKeySeparator = hl(p.fg_dim, p.none),
    WhichKeyFloat = hl(p.fg, p.bg_float),
    WhichKeyBorder = hl(p.fg_inactive, p.bg_float),
    WhichKeyValue = hl(p.fg_dim, p.none),

    LualineNormal = hl(p.fg, p.bg_statusline),

    MiniIconsAzure = hl(p.info, p.none),
    MiniIconsBlue = hl(p.steel, p.none),
    MiniIconsCyan = hl(p.info, p.none),
    MiniIconsGreen = hl(p.success, p.none),
    MiniIconsGrey = hl(p.fg_inactive, p.none),
    MiniIconsOrange = hl(p.match, p.none),
    MiniIconsPurple = hl(p.white, p.none),
    MiniIconsRed = hl(p.error, p.none),
    MiniIconsYellow = hl(p.warning, p.none),

    HopNextKey = hl(p.steel, p.none, { bold = true }),
    HopNextKey1 = hl(p.white, p.none, { bold = true }),
    HopNextKey2 = hl(p.success, p.none),
    HopUnmatched = hl(p.fg_dim, p.none),

    NoiceCmdline = hl(p.fg, p.bg_float),
    NoiceCmdlineIcon = hl(p.steel, p.none),
    NoiceCmdlineIconSearch = hl(p.white, p.none),
    NoiceCmdlinePopup = hl(p.fg, p.bg_float),
    NoiceCmdlinePopupBorder = hl(p.fg_inactive, p.bg_float),
    NoiceConfirm = hl(p.fg, p.bg_float),
    NoiceConfirmBorder = hl(p.fg_inactive, p.bg_float),
    NoiceMini = hl(p.fg, p.bg_statusline),
    NoicePopup = hl(p.fg, p.bg_float),
    NoicePopupBorder = hl(p.fg_inactive, p.bg_float),

    InclineNormal = hl(p.fg, p.bg_statusline),
    InclineNormalNC = hl(p.fg_dim, p.bg_cursor),

    OilDir = hl(p.white, p.none),
    OilDirIcon = hl(p.white, p.none),
    OilFile = hl(p.fg, p.none),
    OilLink = hl(p.link, p.none),
    OilLinkTarget = hl(p.fg_dim, p.none),
    OilCopy = hl(p.success, p.none),
    OilMove = hl(p.warning, p.none),
    OilChange = hl(p.git_change, p.none),
    OilCreate = hl(p.success, p.none),
    OilDelete = hl(p.error, p.none),
    OilPermissionNone = hl(p.fg_dim, p.none),
    OilPermissionRead = hl(p.success, p.none),
    OilPermissionWrite = hl(p.warning, p.none),
    OilPermissionExecute = hl(p.error, p.none),
    OilTypeDir = hl(p.white, p.none),
    OilTypeFile = hl(p.fg, p.none),
    OilTypeLink = hl(p.link, p.none),

    DiffviewFilePanelTitle = hl(p.steel, p.none, { bold = true }),
    DiffviewFilePanelCounter = hl(p.white, p.none),
    DiffviewFilePanelFileName = hl(p.fg, p.none),
    DiffviewFilePanelPath = hl(p.fg_dim, p.none),
    DiffviewFilePanelInsertions = hl(p.git_add, p.none),
    DiffviewFilePanelDeletions = hl(p.git_delete, p.none),
    DiffviewStatusAdded = hl(p.git_add, p.none),
    DiffviewStatusModified = hl(p.git_change, p.none),
    DiffviewStatusDeleted = hl(p.git_delete, p.none),
    DiffviewStatusRenamed = hl(p.warning, p.none),
    DiffviewStatusUntracked = hl(p.fg_dim, p.none),
    DiffviewDim1 = hl(p.fg_dim, p.none),
    DiffviewPrimary = hl(p.steel, p.none),
    DiffviewSecondary = hl(p.white, p.none),

    HarpoonWindow = hl(p.fg, p.bg_float),
    HarpoonBorder = hl(p.fg_inactive, p.bg_float),

    NeotestAdapterName = hl(p.white, p.none, { bold = true }),
    NeotestDir = hl(p.white, p.none),
    NeotestExpandMarker = hl(p.fg_inactive, p.none),
    NeotestFailed = hl(p.error, p.none),
    NeotestFile = hl(p.fg, p.none),
    NeotestFocused = hl(p.none, p.bg_visual),
    NeotestIndent = hl(p.fg_inactive, p.none),
    NeotestMarked = hl(p.warning, p.none),
    NeotestNamespace = hl(p.white, p.none),
    NeotestPassed = hl(p.success, p.none),
    NeotestRunning = hl(p.warning, p.none),
    NeotestSkipped = hl(p.fg_dim, p.none),
    NeotestTarget = hl(p.steel, p.none),
    NeotestTest = hl(p.fg, p.none),
    NeotestWinSelect = hl(p.white, p.none),
    NeotestUnknown = hl(p.fg_dim, p.none),

    UfoFoldedBg = hl(p.none, p.bg_cursor),
    UfoFoldedFg = hl(p.fg_dim, p.none),
    UfoFoldedEllipsis = hl(p.steel, p.none),
    UfoCursorFoldedLine = hl(p.none, p.bg_cursor),

    TodoBgFIX = hl(p.bg_solid, p.error, { bold = true }),
    TodoBgHACK = hl(p.bg_solid, p.steel, { bold = true }),
    TodoBgNOTE = hl(p.bg_solid, p.info, { bold = true }),
    TodoBgPERF = hl(p.bg_solid, p.white, { bold = true }),
    TodoBgTODO = hl(p.bg_solid, p.warning, { bold = true }),
    TodoBgWARN = hl(p.bg_solid, p.warning, { bold = true }),
    TodoFgFIX = hl(p.error, p.none),
    TodoFgHACK = hl(p.steel, p.none),
    TodoFgNOTE = hl(p.info, p.none),
    TodoFgPERF = hl(p.white, p.none),
    TodoFgTODO = hl(p.warning, p.none),
    TodoFgWARN = hl(p.warning, p.none),
    TodoSignFIX = hl(p.error, p.none),
    TodoSignHACK = hl(p.steel, p.none),
    TodoSignNOTE = hl(p.info, p.none),
    TodoSignPERF = hl(p.white, p.none),
    TodoSignTODO = hl(p.warning, p.none),
    TodoSignWARN = hl(p.warning, p.none),

    TinyInlineDiagnosticVirtualTextError = hl(p.error, p.bg_cursor),
    TinyInlineDiagnosticVirtualTextWarn = hl(p.warning, p.bg_cursor),
    TinyInlineDiagnosticVirtualTextInfo = hl(p.info, p.bg_cursor),
    TinyInlineDiagnosticVirtualTextHint = hl(p.hint, p.bg_cursor),

    IncRenameInputBorder = hl(p.steel, p.bg_float),
    IncRenameInputNormal = hl(p.fg, p.bg_float),

    YankyPut = hl(p.none, p.bg_visual),
    YankyYanked = hl(p.none, p.bg_visual),

    RenderMarkdownH1Bg = hl(p.white, p.bg_cursor),
    RenderMarkdownH2Bg = hl(p.white, p.bg_cursor),
    RenderMarkdownH3Bg = hl(p.white, p.bg_cursor),
    RenderMarkdownH4Bg = hl(p.white, p.bg_cursor),
    RenderMarkdownH5Bg = hl(p.white, p.bg_cursor),
    RenderMarkdownH6Bg = hl(p.white, p.bg_cursor),
    RenderMarkdownCode = hl(p.none, p.bg_cursor),
    RenderMarkdownCodeInline = hl(p.string, p.bg_cursor),
    RenderMarkdownBullet = hl(p.steel, p.none),
    RenderMarkdownQuote = hl(p.fg_inactive, p.none),
    RenderMarkdownDash = hl(p.fg_inactive, p.none),
    RenderMarkdownLink = hl(p.link, p.none),
    RenderMarkdownMath = hl(p.white, p.none),
    RenderMarkdownChecked = hl(p.success, p.none),
    RenderMarkdownUnchecked = hl(p.fg_inactive, p.none),
    RenderMarkdownTableHead = hl(p.steel, p.none),
    RenderMarkdownTableRow = hl(p.fg, p.none),
    RenderMarkdownTableFill = hl(p.bg_cursor, p.none),
  }
end

--------------------------------------------------------------------------------
-- TERMINAL COLORS
--------------------------------------------------------------------------------

local function set_terminal_colors(_)
  vim.g.terminal_color_0 = colors.bg_highlight
  vim.g.terminal_color_1 = colors.error_soft
  vim.g.terminal_color_2 = colors.success_soft
  vim.g.terminal_color_3 = colors.warn_soft
  vim.g.terminal_color_4 = colors.turquoise
  vim.g.terminal_color_5 = colors.terracotta
  vim.g.terminal_color_6 = colors.sage
  vim.g.terminal_color_7 = colors.fg_normal
  vim.g.terminal_color_8 = colors.stone
  vim.g.terminal_color_9 = colors.error_soft
  vim.g.terminal_color_10 = colors.success_soft
  vim.g.terminal_color_11 = colors.gold
  vim.g.terminal_color_12 = colors.turquoise
  vim.g.terminal_color_13 = colors.copper
  vim.g.terminal_color_14 = colors.sage
  vim.g.terminal_color_15 = colors.fg_bright
end

--------------------------------------------------------------------------------
-- SETUP
--------------------------------------------------------------------------------

local function setup()
  if vim.g.colors_name then vim.cmd.hi 'clear' end
  if vim.fn.exists 'syntax_on' then vim.cmd.syntax 'reset' end

  vim.o.termguicolors = true
  vim.o.background = 'dark'
  vim.g.colors_name = 'copper-canyon'

  local palette = get_palette()
  local highlights = generate_highlights(palette)
  for group, settings in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, settings)
  end
  set_terminal_colors(palette)
end

setup()

return {
  toggle_transparent = function()
    config.transparent = not config.transparent
    vim.g.copper_canyon_transparent = config.transparent
    setup()
    vim.notify('Copper Canyon: Transparent = ' .. tostring(config.transparent), vim.log.levels.INFO)
  end,
  set_transparent = function(value)
    config.transparent = value
    vim.g.copper_canyon_transparent = value
    setup()
  end,
}
