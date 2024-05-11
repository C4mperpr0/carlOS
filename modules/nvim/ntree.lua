local map_keys = require("dr0med4r.utils").map_keys
local g = vim.g

g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
require("nvim-tree").setup {}
require("nvim-web-devicons").setup {
	color_icons = true,
	default = true,
}

local keymaps = {
    { 'n', '<space>f',   function() vim.cmd.NvimTreeFocus() end },
}
map_keys(keymaps)
