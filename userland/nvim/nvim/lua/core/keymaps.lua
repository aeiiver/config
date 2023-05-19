vim.g.mapleader = ' '

-- open netrw
vim.keymap.set('n', '<leader>e', [[:Ex<CR>]])

-- append next line to current line without moving cursor
vim.keymap.set('n', 'J', [[mjJ`j]])

-- center cursor after half-page scroll jumps
vim.keymap.set('n', '<C-d>', [[<C-d>zz]])
vim.keymap.set('n', '<C-u>', [[<C-u>zz]])
-- center cursor after search jumps & unfold as necessary
vim.keymap.set('n', 'n', [[nzzzv]])
vim.keymap.set('n', 'N', [[Nzzzv]])

-- move lines & fix indent
vim.keymap.set('n', '<M-j>', [[:m .+1<CR>==]])
vim.keymap.set('n', '<M-k>', [[:m .-2<CR>==]])
vim.keymap.set('i', '<M-j>', [[<esc>:m .+1<CR>==gi]])
vim.keymap.set('i', '<M-k>', [[<esc>:m .-2<CR>==gi]])
vim.keymap.set('v', '<M-j>', [[:m '>+1<CR>gv=gv]])
vim.keymap.set('v', '<M-k>', [[:m '<-2<CR>gv=gv]])
-- duplicate lines
vim.keymap.set('n', '<M-J>', [[:co .<CR>]])
vim.keymap.set('n', '<M-K>', [[:co .-1<CR>]])
vim.keymap.set('i', '<M-J>', [[<C-o>:co .<CR>]])
vim.keymap.set('i', '<M-K>', [[<C-o>:co .-1<CR>]])
vim.keymap.set('v', '<M-J>', [[:co '<-1<CR>gv]])
vim.keymap.set('v', '<M-K>', [[:co '><CR>gv]])

-- change indent without quitting out of visual mode
vim.keymap.set('v', '>', [[:><CR>gv]])
vim.keymap.set('v', '<', [[:<<CR>gv]])
-- escape instead of quitting out of insert mode
vim.keymap.set('i', '<C-c>', [[<esc>]])
-- del key
vim.keymap.set('i', '<C-l>', [[<del>]])

-- copy to system clipboard
vim.keymap.set('n', '<leader>yy', [["+yy]])
vim.keymap.set('v', '<leader>y', [["+y]])
-- paste from system clipboard
vim.keymap.set('n', '<leader>p', [["+p]])
vim.keymap.set('n', '<leader>P', [["+P]])
vim.keymap.set('v', '<leader>p', [["+p]])
vim.keymap.set('v', '<leader>P', [["+P]])
-- select latest inserted text
vim.keymap.set('n', '<leader>v', '`[v`]')
-- trim trailing whitespaces
vim.keymap.set('n', '<leader>x', [[mx:%s/\s\+$//e<CR>`x]])

-- substitute all occurences of word under cursor or selection
vim.keymap.set('n', '<M-L>', [[:%s/<C-r><C-w>/<C-r><C-w>/gI<left><left><left>]])
vim.keymap.set('v', '<M-L>', [[""y:%s/<C-r>"/<C-r>"/gI<left><left><left>]])

-- quick search-replace
vim.keymap.set('n', '<M-d>', [[*Ncgn]])
vim.keymap.set('v', '<M-d>', [[*Ncgn]], { remap = true })

-- jump to errors
vim.keymap.set('n', '<C-j>', ':cnext<CR>zz')
vim.keymap.set('n', '<C-k>', ':cprev<CR>zz')
-- jump to locations
vim.keymap.set('n', '<leader>j', ':lnext<CR>zz')
vim.keymap.set('n', '<leader>k', ':lprev<CR>zz')
