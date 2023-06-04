local function transparent_bg(colorscheme)
  vim.cmd.colorscheme(colorscheme)
  vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
end

return {
  {
    'savq/melange-nvim',
    dependencies = { 'rktjmp/lush.nvim' },
    config = function()
      transparent_bg('melange')
    end,
  },
}
