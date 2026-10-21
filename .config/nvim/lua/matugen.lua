 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#1e1c21',
    base01 = '#332f37',
    base02 = '#2e2a32',
    base03 = '#6a666d',
    base04 = '#b3b0b5',
    base05 = '#f2f2f3',
    base06 = '#f2f2f3',
    base07 = '#f2f2f3',
    base08 = '#eba378',
    base09 = '#a290a2',
    base0A = '#9f90a2',
    base0B = '#a69eae',
    base0C = '#c5bac5',
    base0D = '#bfbac5',
    base0E = '#c3bac5',
    base0F = '#dbd5dc',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- telescope.nvim
  hi('TelescopeNormal',         { fg = '#f2f2f3',          bg = '#1e1c21' })
  hi('TelescopeBorder',         { fg = '#6a666d',             bg = '#1e1c21' })
  hi('TelescopePromptNormal',   { fg = '#f2f2f3',          bg = '#1e1c21' })
  hi('TelescopePromptBorder',   { fg = '#6a666d',             bg = '#1e1c21' })
  hi('TelescopePromptPrefix',   { fg = '#a69eae',             bg = '#1e1c21' })
  hi('TelescopePromptCounter',  { fg = '#b3b0b5',  bg = '#1e1c21' })
  hi('TelescopePromptTitle',    { fg = '#1e1c21',             bg = '#a69eae' })
  hi('TelescopePreviewTitle',   { fg = '#1e1c21',             bg = '#9f90a2' })
  hi('TelescopeResultsTitle',   { fg = '#1e1c21',             bg = '#a290a2' })
  hi('TelescopeSelection',      { fg = '#f2f2f3',          bg = '#2e2a32' })
  hi('TelescopeSelectionCaret', { fg = '#a69eae',             bg = '#2e2a32' })
  hi('TelescopeMatching',       { fg = '#a69eae',             bold = true })

  -- mini.pick
  hi('MiniPickNormal',         { fg = '#f2f2f3',          bg = '#1e1c21' })
  hi('MiniPickBorder',         { fg = '#6a666d',             bg = '#1e1c21' })
  hi('MiniPickPrompt',   { fg = '#f2f2f3',          bg = '#1e1c21' })
  hi('MiniPickPromptPrefix',   { fg = '#a69eae',             bg = '#1e1c21' })
  hi('MiniPickBorderText',    { fg = '#1e1c21',             bg = '#a69eae' })
  hi('MiniPickMatchCurrent',      { fg = '#f2f2f3',          bg = '#2e2a32' })
  hi('MiniPickPromptCaret', { fg = '#a69eae',             bg = '#2e2a32' })
  hi('MiniPickMatchRanges',       { fg = '#a69eae',             bold = true })
end

-- Register a signal handler for SIGUSR1 (matugen updates).
-- The handler re-requires this module, which re-runs the code below, so the
-- previous handle is stopped first; otherwise handlers double on every signal.
if _G.__matugen_signal then
  _G.__matugen_signal:stop()
  _G.__matugen_signal:close()
end

local signal = vim.uv.new_signal()
_G.__matugen_signal = signal
signal:start(
  'sigusr1',
  vim.schedule_wrap(function()
    package.loaded['matugen'] = nil
    require('matugen').setup()
  end)
)

return M
