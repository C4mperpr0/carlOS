local M = {}
M.map_keys = function(keymaps)
  -- code
  local opts = { silent = true, noremap = true }
  for _, keymap in pairs(keymaps) do
    vim.keymap.set(keymap[1], keymap[2], keymap[3], opts)
  end
end
return M
