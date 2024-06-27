-- Add the current directory to the runtime path
vim.cmd('set runtimepath+=.')

-- Load common configurations
require('common')

-- Detect the OS and load the respective configuration
local os_name = vim.loop.os_uname().sysname

local os_configs = {
  Darwin = 'config.mac',
  Linux = 'config.ubuntu',
  Windows_NT = 'config.windows'
}

local config_to_load = os_configs[os_name]
if config_to_load then
  require(config_to_load)
else
  vim.notify('Unsupported OS: ' .. os_name, vim.log.levels.ERROR)
end
