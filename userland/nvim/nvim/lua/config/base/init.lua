local function setup()
  require('config.base.options')
  require('config.base.keymaps')
  require('config.base.autocmds')
  require('config.base.statusline')
end

return {
  setup = setup,
}
