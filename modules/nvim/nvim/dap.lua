require("dapui").setup()


local dap = require('dap')

dap.adapters.lldb = {
  type = 'executable',
  command = 'lldb-vscode',
  name = 'lldb'
}
dap.configurations.cpp = {
  {
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    program = function()
      return vim.ui.input({
        prompt = 'Path to executable: ',
        default = vim.fn.getcwd() .. '/',
        completion = 'file'
      }, function(input)
        return input or ""
      end)
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
  },
}


local dapui = require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end




local map_keys = require("dr0med4r.utils").map_keys
local keymaps = {
  { 'n', '<F1>',       function() dap.step_into() end },
  { 'n', '<F2>',       function() dap.step_over() end },
  { 'n', '<F3>',       function() dap.step_out() end },
  { 'n', '<F5>',       function() dap.continue() end },
  { 'n', '<leader>b',  function() dap.toggle_breakpoint() end },
  { 'n', '<leader>B',  function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end },
}
map_keys(keymaps)
