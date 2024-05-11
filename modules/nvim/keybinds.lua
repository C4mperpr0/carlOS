local map_keys = require("dr0med4r.utils").map_keys

local standard_keymaps = {
  { 'n', '<leader>z',  function() vim.cmd.UndotreeToggle() end },
  { 'n', '<leader>n',  ':bn<CR>' },
  { 'n', '<leader>p',  ':bp<CR>' },
  { 'n', '<C-T>',      function() vim.cmd.ToggleTerm() end },
  { 't', '<C-T>',      '<C-\\><C-N>:ToggleTerm<CR>' },
  { 't', '<C-E>',      '<C-\\><C-N>' },
  { 'n', '<C-D>',      '<C-D>zz' },
  { 'n', '<C-U>',      '<C-U>zz' },
  -- move line up or down
  { 'n', '<A-J>',      ':m +1<CR>==' },
  { 'n', '<A-K>',      ':m -2<CR>==' },
  { 'i', '<A-J>',      '<ESC>:m +1<CR>==gi' },
  { 'i', '<A-K>',      '<ESC>:m -2<CR>==gi' },
  { 'v', '<A-J>',      ':m \'>+1<CR>gv=gv' },
  { 'v', '<A-K>',      ':m \'<-2<CR>gv=gv' },
  -- windows
  { 'n', '<A-h>',      '<C-w>h' },
  { 'n', '<A-j>',      '<C-w>j' },
  { 'n', '<A-k>',      '<C-w>k' },
  { 'n', '<A-l>',      '<C-w>l' },
  { 'n', '<A-n>',      '<C-w>v' },
  { 'n', '<A-N>',      '<C-w>s' },
}
map_keys(standard_keymaps)

