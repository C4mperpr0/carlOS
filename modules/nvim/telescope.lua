local map_keys = require("dr0med4r.utils").map_keys
require("telescope").setup {
  prompt_prefix = "$ ",
  selection_caret = "$ ",
  pickers = {
    find_files = { theme = "dropdown", },
    live_grep = { theme = "dropdown", }
  },
}
require("dressing").setup()

local builtin = require('telescope.builtin')

local telescope_keymaps = {
  { 'n', '<C-F>',      builtin.find_files },
  { 'v', '<C-F>',      builtin.find_files },
  { 't', '<C-F>',      builtin.find_files },
  { 'n', '<leader>fg', builtin.live_grep },
  { 'n', '<leader>fb', builtin.buffers },
  { 'n', '<leader>fh', builtin.help_tags },
}
map_keys(telescope_keymaps)
