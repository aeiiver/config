vim.g.mapleader = ' '

local function map(mode, lhs, rhs, opts)
  local merged = vim.tbl_extend('force', { silent = true }, opts)
  vim.keymap.set(mode, lhs, rhs, merged)
end

--[[ toggle settings ]]
map('n', '<M-w>', [[:set wrap!<CR>]], { desc = 'Toggle wrap' })
map('n', '<M-q>', [[:set list!<CR>]], { desc = 'Toggle listchars' })

--[[ navigation ]]
map('n', '<leader>e', [[:Explore<CR>]], { desc = 'Netrw' })

map('n', '<C-d>', [[<C-d>zz]], { desc = 'Scroll down' })
map('n', '<C-u>', [[<C-u>zz]], { desc = 'Scroll up' })
map('n', 'n', [[nzzzv]], { desc = 'Repeat search' })
map('n', 'N', [[Nzzzv]], { desc = 'Repeat search backwards' })

map('n', '<C-j>', [[:cnext<CR>]], { desc = 'Next quickfix item' })
map('n', '<C-k>', [[:cprev<CR>]], { desc = 'Previous quickfix item' })
map('n', '<C-M-j>', [[:lnext<CR>]], { desc = 'Next location item' })
map('n', '<C-M-k>', [[:lprev<CR>]], { desc = 'Previous location item' })

--[[ convenience (the truth is idk where to put those) ]]
map('i', '<C-c>', [[<esc>]], { desc = 'Escape' })
map('n', '<leader>v', '`[v`]', { desc = 'Select last yanked/changed text' })

--[[ search/replace ]]
map('n', '<M-d>', [[*Ncgn]], { desc = 'Change word with *' })
map('v', '<M-d>', [[*Ncgn]], { desc = 'Change selection with *', remap = true })

--[[ linewise ]]
map('n', 'J', [[mjJ`j]], { desc = 'Join lines' })

map('n', '<M-j>', [[:m .+1<CR>==]], { desc = 'Move line down' })
map('n', '<M-k>', [[:m .-2<CR>==]], { desc = 'Move line up' })
map('v', '<M-j>', [[:m '>+1<CR>gv=gv]], { desc = 'Move lines down' })
map('v', '<M-k>', [[:m '<-2<CR>gv=gv]], { desc = 'Move lines up' })

map('n', '<M-J>', [[:co .<CR>]], { desc = 'Copy line down' })
map('n', '<M-K>', [[:co .-1<CR>]], { desc = 'Copy line up' })
map('v', '<M-J>', [[:co '<-1<CR>gv]], { desc = 'Copy lines down' })
map('v', '<M-K>', [[:co '><CR>gv]], { desc = 'Copy lines up' })

map('v', '>', [[>gv]], { desc = 'Indent' })
map('v', '<', [[<gv]], { desc = 'Outdent' })

--[[ filewise ]]
-- stylua: ignore
map( 'n', '<leader>x', [[mx:%s/\s\+$//e<CR>`x]], { desc = 'Trim trailing whitespaces' })

--[[ system clipboard ]]
map('n', '<leader>yy', [["+yy]], { desc = 'Yank to "+' })
map('v', '<leader>y', [["+y]], { desc = 'Yank to "+' })

map('n', '<leader>p', [["+p]], { desc = 'Put from "+' })
map('n', '<leader>P', [["+P]], { desc = 'Put from "+' })
map('v', '<leader>p', [["+p]], { desc = 'Put from "+' })
map('v', '<leader>P', [["+P]], { desc = 'Put from "+' })

--[[ window ]]
map('n', '<C-Up>', [[:resize -2<CR>]], { desc = 'Resize up' })
map('n', '<C-Down>', [[:resize +2<CR>]], { desc = 'Resize down' })
map('n', '<C-Left>', [[:vert resize -2<CR>]], { desc = 'Resize left' })
map('n', '<C-Right>', [[:vert resize +2<CR>]], { desc = 'Resize right' })
