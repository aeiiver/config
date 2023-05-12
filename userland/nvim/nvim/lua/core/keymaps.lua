vim.g.mapleader = ' '

local bind = vim.keymap.set

-- open netrw
bind('n', '<leader>e', [[:Ex<CR>]])

-- append next line to current line without moving cursor
bind('n', 'J', [[mjJ`j]])

-- center cursor after half-page scroll jumps
bind('n', '<C-d>', [[<C-d>zz]])
bind('n', '<C-u>', [[<C-u>zz]])
-- center cursor after search jumps & unfold as necessary
bind('n', 'n', [[nzzzv]])
bind('n', 'N', [[Nzzzv]])

-- move lines & fix indent
bind('n', '<M-j>', [[:m .+1<CR>==]])
bind('n', '<M-k>', [[:m .-2<CR>==]])
bind('i', '<M-j>', [[<esc>:m .+1<CR>==gi]])
bind('i', '<M-k>', [[<esc>:m .-2<CR>==gi]])
bind('v', '<M-j>', [[:m '>+1<CR>gv=gv]])
bind('v', '<M-k>', [[:m '<-2<CR>gv=gv]])
-- duplicate lines
bind('n', '<M-J>', [[:co .<CR>]])
bind('n', '<M-K>', [[:co .-1<CR>]])
bind('i', '<M-J>', [[<C-o>:co .<CR>]])
bind('i', '<M-K>', [[<C-o>:co .-1<CR>]])
bind('v', '<M-J>', [[:co '<-1<CR>gv]])
bind('v', '<M-K>', [[:co '><CR>gv]])

-- change indent without quitting out of visual mode
bind('v', '>', [[:><CR>gv]])
bind('v', '<', [[:<<CR>gv]])
-- escape instead of quitting out of insert mode
bind('i', '<C-c>', [[<esc>]])
-- del key
bind('i', '<C-l>', [[<del>]])

-- copy to system clipboard
bind('n', '<leader>yy', [["+yy]])
bind('v', '<leader>y', [["+y]])
-- paste from system clipboard
bind('n', '<leader>p', [["+p]])
bind('n', '<leader>P', [["+P]])
bind('v', '<leader>p', [["+p]])
bind('v', '<leader>P', [["+P]])
-- select latest inserted text
bind('n', '<leader>v', '`[v`]')
-- trim trailing whitespaces
bind('n', '<leader>x', [[mx:%s/\s\+$//e<CR>`x]])

-- substitute all occurences of word under cursor or selection
bind('n', '<M-L>', [[:%s/<C-r><C-w>/<C-r><C-w>/gI<left><left><left>]])
bind('v', '<M-L>', [[""y:%s/<C-r>"/<C-r>"/gI<left><left><left>]])

-- quick search-replace
bind('n', '<M-d>', [[*Ncgn]])
bind('v', '<M-d>', [[*Ncgn]], { remap = true })

-- jump to errors
bind('n', '<C-j>', ':cnext<CR>zz')
bind('n', '<C-k>', ':cprev<CR>zz')
-- jump to locations
bind('n', '<leader>j', ':lnext<CR>zz')
bind('n', '<leader>k', ':lprev<CR>zz')
