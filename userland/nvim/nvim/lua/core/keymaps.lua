vim.g.mapleader = ' '

local function km(mode, lhs, rhs, opts)
  local defaults = { noremap = true, silent = true }
  local merged = vim.tbl_deep_extend('force', defaults, opts)
  vim.keymap.set(mode, lhs, rhs, merged)
end

-- toggle options
km('n', '<M-w>', [[:set wrap!<CR>]], { desc = 'Toggle wrap' })
km('n', '<M-q>', [[:set list!<CR>]], { desc = 'Toggle listchars' })

-- navigation
km('n', '<Leader>e', [[:Explore<CR>]], { desc = 'Explore' })

km('n', '<C-d>', [[<C-d>zz]], { desc = 'Page down' })
km('n', '<C-u>', [[<C-u>zz]], { desc = 'Page up' })
km('n', 'n', [[nzzzv]], { desc = 'Repeat search' })
km('n', 'N', [[Nzzzv]], { desc = 'Repeat search in the opposite direction' })

km('n', '<C-j>', [[:cnext<CR>]], { desc = 'Next quicklist item' })
km('n', '<C-k>', [[:cprev<CR>]], { desc = 'Previous quicklist item' })
km('n', '<C-M-j>', [[:lnext<CR>]], { desc = 'Next location item' })
km('n', '<C-M-k>', [[:lprev<CR>]], { desc = 'Previous location item' })

-- convenience (the truth is idk where to put those)
km('i', '<C-c>', [[<Esc>]], { desc = 'Escape' })
km('n', '<Leader>v', '`[v`]', { desc = 'Select yanked, inserted or selected' })

-- search/replace
km('n', '<M-d>', [[*Ncgn]], { desc = 'Change word with *' })
km('v', '<M-d>', [[*Ncgn]], { remap = true, desc = 'Change selection with *' })

-- linewise
km('n', 'J', [[mjJ`j]], { desc = 'Join lines' })

km('n', '<M-j>', [[:m .+1<CR>==]], { desc = 'Move line down' })
km('n', '<M-k>', [[:m .-2<CR>==]], { desc = 'Move line up' })
km('v', '<M-j>', [[:m '>+1<CR>gv=gv]], { desc = 'Move lines down' })
km('v', '<M-k>', [[:m '<-2<CR>gv=gv]], { desc = 'Move lines up' })

km('n', '<M-J>', [[:co .<CR>]], { desc = 'Copy line down' })
km('n', '<M-K>', [[:co .-1<CR>]], { desc = 'Copy line up' })
km('v', '<M-J>', [[:co '<-1<CR>gv]], { desc = 'Copy lines down' })
km('v', '<M-K>', [[:co '><CR>gv]], { desc = 'Copy lines up' })

km('v', '>', [[>gv]], { desc = 'Indent' })
km('v', '<', [[<gv]], { desc = 'Outdent' })

-- filewise
km(
  'n',
  '<Leader>x',
  [[mx:%s/\s\+$//e<CR>`x]],
  { desc = 'Trim trailing whitespaces' }
)

-- system clipboard
km('n', '<Leader>yy', [["+yy]], { desc = 'Yank to system clipboard' })
km('v', '<Leader>y', [["+y]], { desc = 'Yank to system clipboard' })

km('n', '<Leader>p', [["+p]], { desc = 'Put from system clipboard' })
km('n', '<Leader>P', [["+P]], { desc = 'Put from system clipboard' })
km('v', '<Leader>p', [["+p]], { desc = 'Put from system clipboard' })
km('v', '<Leader>P', [["+P]], { desc = 'Put from system clipboard' })

-- window
km('n', '<C-Up>', [[:resize -2<CR>]], { desc = 'Resize up' })
km('n', '<C-Down>', [[:resize +2<CR>]], { desc = 'Resize down' })
km('n', '<C-Left>', [[:vert resize -2<CR>]], { desc = 'Vert resize left' })
km('n', '<C-Right>', [[:vert resize +2<CR>]], { desc = 'Vert resize right' })
