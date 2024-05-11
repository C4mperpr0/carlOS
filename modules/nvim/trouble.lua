local map_keys = require("dr0med4r.utils").map_keys

local keymaps = {

  { "n", "<leader>xx", function() vim.cmd.TroubleToggle() end },
  { "n", "<leader>xw", function() vim.cmd.TroubleToggle("workspace_diagnostics") end },
  { "n", "<leader>xd", function() vim.cmd.TroubleToggle("document_diagnostics") end },
  { "n", "<leader>xl", function() vim.cmd.TroubleToggle("loclist") end },
  { "n", "<leader>xq", function() vim.cmd.TroubleToggle("quickfix") end },
  { "n", "gR",         function() vim.cmd.TroubleToggle("lsp_references") end },
}
map_keys(keymaps)
