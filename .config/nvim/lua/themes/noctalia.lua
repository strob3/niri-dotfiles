local M = {}

M.base_30 = {
  white = "#cdd6f4",
  darker_black = "#212232",
  black = "#1e1e2e",
  black2 = "#272839",
  one_bg = "#313244",
  one_bg2 = "#3a3b50",
  one_bg3 = "#42435c",
  grey = "#6c7086",
  grey_fg = "#6c7086",
  grey_fg2 = "#a6adc8",
  light_grey = "#a6adc8",
  red = "#f38ba8",
  baby_pink = "#96e9db",
  pink = "#94e2d5",
  line = "#42435c",
  green = "#a6e3a1",
  vibrant_green = "#a6e3a1",
  nord_blue = "#ed91d4",
  blue = "#f5c2e7",
  yellow = "#f9e2af",
  sun = "#f9e2af",
  purple = "#fab387",
  dark_purple = "#fab185",
  teal = "#94e2d5",
  orange = "#94e2d5",
  cyan = "#94e2d5",
  statusline_bg = "#313244",
  lightbg = "#3a3b50",
  pmenu_bg = "#f5c2e7",
  folder_bg = "#f5c2e7",
}

M.base_16 = {
  base00 = "#1e1e2e",
  base01 = "#313244",
  base02 = "#3a3b50",
  base03 = "#6c7086",
  base04 = "#a6adc8",
  base05 = "#cdd6f4",
  base06 = "#cdd6f4",
  base07 = "#cdd6f4",
  base08 = "#f38ba8",
  base09 = "#94e2d5",
  base0A = "#fab387",
  base0B = "#a6e3a1",
  base0C = "#94e2d5",
  base0D = "#f5c2e7",
  base0E = "#fab185",
  base0F = "#fcd0b6",
}

M.type = "dark"

M = require("base46").override_theme(M, "noctalia")

return M
