local function map(mode, lhs, rhs, opts)
  local merged = vim.tbl_extend('force', { silent = true }, opts or {})
  vim.keymap.set(mode, lhs, rhs, merged)
end

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- stylua: ignore start
map('n', '<M-q>', [[:setlocal list!<CR>]], { desc = 'Toggle hidden characters' })
map('n', '<M-w>', [[:setlocal wrap!<CR>]], { desc = 'Toggle word wrap' })
map('n', '<M-e>', [[:setlocal hlsearch!<CR>]], { desc = 'Toggle search highlights' })
-- stylua: ignore end

map('n', '<M-j>', [[:lnext<CR>]], { desc = 'Next location item' })
map('n', '<M-k>', [[:lprev<CR>]], { desc = 'Previous location item' })
map('n', '<C-j>', [[:cnext<CR>]], { desc = 'Next quickfix item' })
map('n', '<C-k>', [[:cprev<CR>]], { desc = 'Previous quickfix item' })

map('v', '>', [[>gv]], { desc = 'Indent' })
map('v', '<', [[<gv]], { desc = 'Outdent' })

-- stylua: ignore
map('n', '<leader>x', [[:%s/\s\+$//e<CR>]], { desc = 'Trim trailing whitespaces' })
map('n', '<leader>d', [[*Ncgn]], { desc = 'Change word with *' })
map('v', '<leader>d', [[*Ncgn]], { desc = 'Change selection with *', remap = true })
map('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<left><left><left>]], { desc = 'Substitute', silent = false })
map('n', '<leader>v', '`[v`]', { desc = 'Select last changed or yanked text' })
map('i', '<C-c>', [[<esc>]], { desc = 'Escape' })

map('n', '<leader>y', [["+y]], { desc = 'Yank to system clipboard' })
map('n', '<leader>yy', [["+yy]], { desc = 'Yank to system clipboard' })
map('v', '<leader>y', [["+y]], { desc = 'Yank to system clipboard' })
map('n', '<leader>p', [["+p]], { desc = 'Put from system clipboard' })
map('n', '<leader>P', [["+P]], { desc = 'Put from system clipboard' })
map('v', '<leader>p', [["+p]], { desc = 'Put from system clipboard' })
map('v', '<leader>P', [["+P]], { desc = 'Put from system clipboard' })

-- stylua: ignore start
map('n', '<C-up>', [[:resize -2<CR>]], { desc = 'Decrease window height' })
map('n', '<C-down>', [[:resize +2<CR>]], { desc = 'Increase window height' })
map('n', '<C-left>', [[:vert resize -2<CR>]], { desc = 'Decrease window width' })
map('n', '<C-right>', [[:vert resize +2<CR>]], { desc = 'Increase window width' })
-- stylua: ignore end

map('n', '<leader>e', [[:Explore<CR>]], { desc = 'Netrw' })
vim.api.nvim_create_autocmd('FileType', {
  desc = 'Map keys for Netrw buffers',
  group = vim.api.nvim_create_augroup('config_netrw_keymaps', {}),
  pattern = 'netrw',
  callback = function(args)
    -- stylua: ignore start
    map('n', 'h', [[-]], { desc = 'Go to parent directory', buffer = args.buf, remap = true })
    map('n', 'l', [[<CR>]], { desc = 'Open file', buffer = args.buf, remap = true })
    -- stylua: ignore end
  end,
})
