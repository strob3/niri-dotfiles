-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "decay",
	hl_override = {
		NvDashAscii = { fg = "blue" },
	},
}

M.nvdash = {
  load_on_startup = true,

  header = {
    "  ███▄▄▄      ▄████████  ▄█████▄   ▄█    █▄   ▄█    ▄▄▄███▄▄▄▄",
    " ███████▄   ███    ███ ███   ▀██ ███    ███ ███▀ ▄████████████",
    " ███   ██   ███    ██▀ ███    ██ ███    ███ ███  ███  ███   ███",
    " ███   ██   ███    ▀   ███    ██ ███    ███ ███  ███  ███   ███",
    " ███   ██ ▄███████     ███    ██ ███    ███ ███  ███  ███   ███",
    " ███   ██   ███    ▄   ███    ██ ███    ███ ███  ███  ███   ███",
    " ███   ██   ███    ██▄ ███    ██ ███    ███ ███  ███  ███   ███",
    " ▀▀█▄  ▀█   ▀██▄▄▄▄███▄▀▀█▄▄▄▄██ ▀▀█▄▄▄▄███ ▀██  ▀▀█▄ ▀██▄  ▀██",
    "    ▀        ▀▀▀▀▀▀▀▀▀▀   ▀▀▀▀▀     ▀▀▀▀▀▀   ▀      ▀  ▀▀▀   ▀",
  },

  buttons = {
    { txt = "  Find File", keys = "f", cmd = "Telescope find_files", no_gap = false },
    { txt = "  New File", keys = "n", cmd = "ene <BAR> startinsert", no_gap = false },
    { txt = "  Find Text", keys = "g", cmd = "Telescope live_grep", no_gap = false },
    { txt = "  Recent Files", keys = "r", cmd = "Telescope oldfiles", no_gap = false },
    { txt = "  Config", keys = "c", cmd = "lua require('telescope.builtin').find_files({ cwd = vim.fn.stdpath('config') })", no_gap = false },
    { txt = "  Restore Session", keys = "s", cmd = "lua require('persistence').load()", no_gap = false },
    { txt = "󱥚  Themes", keys = "t", cmd = "lua require('nvchad.themes').open()", no_gap = false },
    { txt = "󰒲  Lazy", keys = "L", cmd = "Lazy", no_gap = false },
    { txt = "  Quit", keys = "q", cmd = "qa" },

    {
      txt = function()
        local stats = require("lazy").stats()
        local ms = math.floor(stats.startuptime * 100 + 0.5) / 100
        return "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms"
      end,
      hl = "NvDashFooter",
      no_gap = true,
      content = "fit",
    },
  },
}

return M

