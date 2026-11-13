require "nvchad.autocmds"

-- Reload NvChad Base46 theme on Noctalia palette update (SIGUSR1)
if not _G.__noctalia_signal then
  local signal = vim.uv.new_signal()
  _G.__noctalia_signal = signal
  signal:start(
    "sigusr1",
    vim.schedule_wrap(function()
      package.loaded["themes.noctalia"] = nil
      require("base46").load_all_highlights()
    end)
  )
end
