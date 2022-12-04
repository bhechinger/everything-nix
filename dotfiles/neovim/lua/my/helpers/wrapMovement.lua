local M = {}

local function swap(key)
  vim.keymap.set("n", key, "g" .. key, { buffer = true })
  vim.keymap.set("n", "g" .. key, key, { buffer = true })
end

-- Same as swap, but the key is aprt of an arpeggio chord
local function swapArpeggio(key)
  vim.keymap.set("n", "<Plug>(arpeggio-default:" .. key .. ")", "g" .. key, { buffer = true })
  vim.keymap.set("n", "g" .. key, key, { buffer = true })
end

function M.setup()
  swapArpeggio("j")
  swap("k")
  swap("0")
  swap("$")
end

return M