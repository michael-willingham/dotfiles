-- Appearance
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.colorcolumn = "80,120"
vim.opt.signcolumn = "yes"
vim.opt.showmode = true

-- Cursor shapes: block normal, bar insert, underline visual
vim.opt.guicursor = "n-c-sm:block,i-ci-ve:ver25,v-r-cr-o:hor20"

-- Wrapping
vim.opt.wrap = true
vim.opt.linebreak = true

-- Whitespace display
vim.opt.list = true
vim.opt.listchars = { tab = "→ ", trail = "·", nbsp = "␣", leadmultispace = "│ " }

-- Indentation
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Misc
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.updatetime = 250
vim.opt.undofile = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"

-- Folding (indent-based, great for YAML/k8s manifests)
vim.opt.foldmethod = "indent"
vim.opt.foldlevelstart = 99 -- start with everything unfolded

-- Briefly highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

-- Restore cursor position when reopening a file
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(0) then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})

-- Strip trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd([[%s/\s\+$//e]])
    vim.api.nvim_win_set_cursor(0, pos)
  end,
})

------------------------------------------------------------
-- ayu dark colorscheme (built-in approximation)
------------------------------------------------------------
-- Neovim ships with no ayu theme, so we define it inline.
-- Colors pulled from ayu-dark palette.
local function set_ayu_dark()
  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  local bg        = "#0d1017"
  local bg_light  = "#131721"
  local fg        = "#bfbdb6"
  local comment   = "#636a72"
  local accent    = "#e6b450"
  local keyword   = "#ff8f40"
  local string_c  = "#aad94c"
  local func      = "#ffb454"
  local type_c    = "#39bae6"
  local constant  = "#d2a6ff"
  local error_c   = "#d95757"
  local warning   = "#e6b450"
  local selection = "#1a1f29"
  local line_nr   = "#454b54"
  local cursor_ln = "#131721"
  local visual    = "#1d3b53"
  local border    = "#454b54"
  local pmenu_bg  = "#15191e"

  -- Editor
  hi("Normal",       { fg = fg, bg = bg })
  hi("NormalFloat",  { fg = fg, bg = pmenu_bg })
  hi("FloatBorder",  { fg = border, bg = pmenu_bg })
  hi("CursorLine",   { bg = cursor_ln })
  hi("CursorLineNr", { fg = accent, bold = true })
  hi("LineNr",       { fg = line_nr })
  hi("Visual",       { bg = visual })
  hi("Search",       { fg = bg, bg = accent })
  hi("IncSearch",    { fg = bg, bg = keyword })
  hi("ColorColumn",  { bg = bg_light })
  hi("SignColumn",   { bg = bg })
  hi("VertSplit",    { fg = border, bg = bg })
  hi("WinSeparator", { fg = border, bg = bg })
  hi("StatusLine",   { fg = fg, bg = bg_light })
  hi("StatusLineNC", { fg = comment, bg = bg_light })
  hi("Pmenu",        { fg = fg, bg = pmenu_bg })
  hi("PmenuSel",     { fg = bg, bg = type_c })
  hi("PmenuSbar",    { bg = bg_light })
  hi("PmenuThumb",   { bg = comment })
  hi("TabLine",      { fg = comment, bg = bg_light })
  hi("TabLineSel",   { fg = fg, bg = bg })
  hi("TabLineFill",  { bg = bg_light })
  hi("Folded",       { fg = comment, bg = bg_light })
  hi("NonText",      { fg = border })
  hi("SpecialKey",   { fg = border })
  hi("MatchParen",   { fg = accent, bold = true, underline = true })
  hi("Directory",    { fg = type_c })
  hi("Title",        { fg = accent, bold = true })
  hi("MoreMsg",      { fg = string_c })
  hi("Question",     { fg = string_c })
  hi("WarningMsg",   { fg = warning })
  hi("ErrorMsg",     { fg = error_c, bold = true })
  hi("WildMenu",     { fg = bg, bg = accent })

  -- Syntax
  hi("Comment",     { fg = comment, italic = true })
  hi("Constant",    { fg = constant })
  hi("String",      { fg = string_c })
  hi("Character",   { fg = string_c })
  hi("Number",      { fg = constant })
  hi("Boolean",     { fg = constant })
  hi("Float",       { fg = constant })
  hi("Identifier",  { fg = fg })
  hi("Function",    { fg = func })
  hi("Statement",   { fg = keyword })
  hi("Conditional", { fg = keyword })
  hi("Repeat",      { fg = keyword })
  hi("Label",       { fg = keyword })
  hi("Operator",    { fg = keyword })
  hi("Keyword",     { fg = keyword })
  hi("Exception",   { fg = keyword })
  hi("PreProc",     { fg = keyword })
  hi("Include",     { fg = keyword })
  hi("Define",      { fg = keyword })
  hi("Macro",       { fg = keyword })
  hi("Type",        { fg = type_c })
  hi("StorageClass",{ fg = keyword })
  hi("Structure",   { fg = type_c })
  hi("Typedef",     { fg = type_c })
  hi("Special",     { fg = accent })
  hi("SpecialChar", { fg = accent })
  hi("Tag",         { fg = type_c })
  hi("Delimiter",   { fg = fg })
  hi("Debug",       { fg = error_c })
  hi("Underlined",  { underline = true })
  hi("Error",       { fg = error_c })
  hi("Todo",        { fg = accent, bold = true })

  -- Diagnostics
  hi("DiagnosticError", { fg = error_c })
  hi("DiagnosticWarn",  { fg = warning })
  hi("DiagnosticInfo",  { fg = type_c })
  hi("DiagnosticHint",  { fg = comment })
  hi("DiagnosticUnderlineError", { sp = error_c, undercurl = true })
  hi("DiagnosticUnderlineWarn",  { sp = warning, undercurl = true })
  hi("DiagnosticUnderlineInfo",  { sp = type_c, undercurl = true })
  hi("DiagnosticUnderlineHint",  { sp = comment, undercurl = true })

  -- Treesitter (if grammar installed via :TSInstall)
  hi("@variable",          { fg = fg })
  hi("@function",          { fg = func })
  hi("@function.builtin",  { fg = func })
  hi("@keyword",           { fg = keyword })
  hi("@keyword.return",    { fg = keyword })
  hi("@string",            { fg = string_c })
  hi("@type",              { fg = type_c })
  hi("@type.builtin",      { fg = type_c })
  hi("@constant",          { fg = constant })
  hi("@constant.builtin",  { fg = constant })
  hi("@comment",           { fg = comment, italic = true })
  hi("@punctuation",       { fg = fg })
  hi("@punctuation.bracket",   { fg = fg })
  hi("@punctuation.delimiter", { fg = fg })
  hi("@parameter",         { fg = fg })
  hi("@property",          { fg = fg })
  hi("@field",             { fg = fg })
  hi("@operator",          { fg = keyword })
  hi("@namespace",         { fg = type_c })
  hi("@tag",               { fg = type_c })
  hi("@tag.attribute",     { fg = func })
  hi("@tag.delimiter",     { fg = fg })

  -- Diff
  hi("DiffAdd",    { bg = "#1d3b2f" })
  hi("DiffChange", { bg = "#1d3b53" })
  hi("DiffDelete", { fg = error_c, bg = "#3b1d1d" })
  hi("DiffText",   { bg = "#2d4f6f" })
end

set_ayu_dark()

-- Re-apply on ColorScheme event (in case something resets it)
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = set_ayu_dark,
})
