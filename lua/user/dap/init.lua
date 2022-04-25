-- TODO: decrease the size of the terminal with debug output
local status_ok, _ = pcall(require, "dap")
if not status_ok then
    return
end

require "user.dap.dap"
require "user.dap.dap-python"
require "user.dap.dapui"
require "user.dap.dap-virtual-text"
