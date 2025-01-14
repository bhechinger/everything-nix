local H = require("my.plugins.themes.helpers")

local M = {
  "rose-pine/neovim",
  name = "rose-pine",
  lazy = false,
  enabled = H.theme_contains("Rosé Pine"),
}

function M.config()
  local variant = H.variant("Rosé Pine")

  if variant == "dawn" then
    vim.o.background = "light"
  else
    vim.o.background = "dark"
  end

  local dark_variants = {
    [""] = "main",
    moon = "moon",
  }

  require("rose-pine").setup({
    dark_variant = dark_variants[variant],
  })

  vim.cmd("colorscheme rose-pine")
end

return M
