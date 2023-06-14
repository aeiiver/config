local M = {}

M.setup = function()
  require('config.base.options')
  require('config.base.keymaps')
  require('config.base.autocmds')
  require('config.base.statusline')
end

return M
