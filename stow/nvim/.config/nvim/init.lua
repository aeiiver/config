---
--- Emacs's compile command
---

vim.keymap.set('n', '<Space>m', function()
    vim.ui.input({
        prompt = 'Run: ',
        default = vim.opt.makeprg:get(),
    }, function(input)
        if input == nil then
            return
        end
        vim.opt.makeprg = input
        vim.cmd('silent make | copen')
    end)
end)

---
--- Quick `.editorconfig` edit
---

vim.api.nvim_create_user_command('EditorConfig', function()
    local dest = '.editorconfig'
    vim.cmd.tabedit(dest)
    if vim.fn.findfile(dest) == '' then
        vim.api.nvim_buf_set_lines(0, 0, 1, false, {
            '# EditorConfig is awesome: https://EditorConfig.org',
            '',
            'root = true',
            '',
            '[*]',
            'indent_style = space',
            'indent_size = 4',
            'tab_width = 4',
            'end_of_line = lf',
            'charset = utf-8',
            'trim_trailing_whitespace = true',
            'insert_final_newline = true',
        })
    end
end, {})

---
--- Colorscheme
---
--- Run `:au BufWritePost <buffer> so %` for hot-reloading.

local black = '#000000'
local gray1 = '#c0c0c0'
local gray2 = '#808080'
local gray3 = '#606060'
local bg1 = '#080404'
local bg2 = '#161010'

local plus = gray3
local delta = gray2
local minus = gray1

local hardcoded = gray2
local userdefined = gray1
local langdefined = gray3
local ignorable = gray3

local heading = gray2
local link = gray2
local raw = gray3
local list = gray3

local colorscheme = {
    -- :h highlight-default

    ['CurSearch'] = {fg = black, bg = gray1},

    ['CursorLine'] = {bg = bg2},
    ['Directory']  = {fg = gray2},
    ['DiffAdd']    = {fg = black, bg = plus},
    ['DiffChange'] = {fg = black, bg = delta},
    ['DiffDelete'] = {fg = black, bg = minus},
    ['DiffText']   = {fg = black, bg = gray1},

    ['ErrorMsg'] = {fg = gray1, bold = true},

    ['Substitute'] = {link = 'CurSearch'},

    ['MatchParen'] = {link = 'CurSearch'},
    ['ModeMsg']    = {link = 'ErrorMsg'},

    ['MoreMsg'] = {link = 'ErrorMsg'},

    ['Normal']       = {fg = gray1, bg = bg1},
    ['NormalFloat']  = {fg = gray1, bg = bg1},

    ['FloatTitle']  = {link = 'Title'},
    ['FloatFooter'] = {link = 'Title'},

    ['Question']     = {link = 'ErrorMsg'},
    ['QuickFixLine'] = {link = 'ErrorMsg'},
    ['Search']       = {link = 'CurSearch'},

    ['SpellBad']     = {undercurl = true},
    ['SpellCap']     = {undercurl = true},
    ['SpellLocal']   = {undercurl = true},
    ['SpellRare']    = {undercurl = true},
    ['StatusLine']   = {fg = gray1, bg = bg2, bold = true},
    ['StatusLineNC'] = {fg = gray2, bg = bg2},

    ['Title'] = {fg = gray1, bold = true},

    ['WarningMsg'] = {link = 'ErrorMsg'},

    -- :h group-name

    ['Comment'] = {link = '@comment'},

    ['Constant']  = {link = '@constant'},
    ['String']    = {link = '@string'},
    ['Character'] = {link = '@character'},
    ['Number']    = {link = '@number'},
    ['Boolean']   = {link = '@boolean'},
    ['Float']     = {link = '@number.float'},

    ['Identifier'] = {link = '@variable'},
    ['Function']   = {link = '@function'},

    ['Statement']   = {link = '@keyword'},
    ['Conditional'] = {link = '@keyword.conditional'},
    ['Repeat']      = {link = '@keyword.repeat'},
    ['Label']       = {link = '@label'},
    ['Operator']    = {link = '@operator'},
    ['Keyword']     = {link = '@keyword'},
    ['Exception']   = {link = '@keyword.exception'},

    ['PreProc']   = {link = '@keyword.directive'},
    ['Include']   = {link = '@keyword.directive'},
    ['Define']    = {link = '@keyword.directive.define'},
    ['Macro']     = {link = 'Define'},
    ['PreCondit'] = {link = '@keyword.directive'},

    ['Type']         = {link = '@type'},
    ['StorageClass'] = {link = '@type'},
    ['Structure']    = {link = '@type'},
    ['Typedef']      = {link = '@type.definition'},

    ['Special']        = {link = '@keyword'},
    ['SpecialChar']    = {link = '@character.special'},
    ['Tag']            = {link = '@keyword'},
    ['Delimiter']      = {link = '@punctuation.delimiter'},
    ['SpecialComment'] = {link = '@comment'},
    ['Debug']          = {link = '@keyword.debug'},

    ['Underlined'] = {underline = true},

    ['Ignore'] = {},

    ['Error'] = {fg = black, bg = gray1},

    ['Todo'] = {fg = gray1, bold = true},

    ['Added']   = {link = '@diff.plus'},
    ['Changed'] = {link = '@diff.delta'},
    ['Removed'] = {link = '@diff.minus'},

    -- :h treesitter-highlight-groups

    ['@variable']                   = {fg = userdefined},
    ['@variable.builtin']           = {fg = langdefined, bold = true},
    ['@variable.parameter']         = {fg = userdefined, bold = true},
    ['@variable.parameter.builtin'] = {fg = langdefined, bold = true},
    ['@variable.member']            = {fg = userdefined},

    ['@constant']         = {fg = hardcoded},
    ['@constant.builtin'] = {fg = langdefined},
    ['@constant.macro']   = {fg = hardcoded},

    ['@module']         = {link = '@variable'},
    ['@module.builtin'] = {fg = langdefined},
    ['@label']          = {link = '@variable'},

    ['@string']                = {fg = hardcoded},
    ['@string.documentation']  = {fg = hardcoded},
    ['@string.regexp']         = {fg = langdefined},
    ['@string.escape']         = {fg = langdefined},
    ['@string.special']        = {fg = hardcoded},
    ['@string.special.symbol'] = {fg = hardcoded},
    ['@string.special.path']   = {fg = hardcoded},
    ['@string.special.url']    = {fg = hardcoded, underline = true},

    ['@character']         = {fg = hardcoded},
    ['@character.special'] = {fg = langdefined},

    ['@boolean']      = {fg = hardcoded},
    ['@number']       = {fg = hardcoded},
    ['@number.float'] = {fg = hardcoded},

    ['@type']            = {fg = langdefined},
    ['@type.builtin']    = {fg = langdefined},
    ['@type.definition'] = {fg = langdefined},

    ['@attribute']         = {fg = userdefined},
    ['@attribute.builtin'] = {fg = langdefined},
    ['@property']          = {fg = userdefined},

    ['@function']         = {fg = userdefined},
    ['@function.builtin'] = {fg = langdefined},
    ['@function.call']    = {fg = userdefined},
    ['@function.macro']   = {fg = userdefined},

    ['@function.method']      = {link = '@function'},
    ['@function.method.call'] = {link = '@function'},

    ['@constructor'] = {link = '@function'},
    ['@operator']    = {fg = langdefined},

    ['@keyword']           = {fg = langdefined, bold = true},
    ['@keyword.coroutine'] = {fg = langdefined, bold = true},
    ['@keyword.function']  = {fg = langdefined, bold = true},
    ['@keyword.operator']  = {fg = langdefined, bold = true},
    ['@keyword.import']    = {fg = langdefined, bold = true},
    ['@keyword.type']      = {fg = langdefined, bold = true},
    ['@keyword.modifier']  = {fg = langdefined, bold = true},
    ['@keyword.repeat']    = {fg = langdefined, bold = true},
    ['@keyword.return']    = {fg = langdefined, bold = true},
    ['@keyword.debug']     = {fg = langdefined, bold = true},
    ['@keyword.exception'] = {fg = langdefined, bold = true},

    ['@keyword.conditional']         = {fg = langdefined, bold = true},
    ['@keyword.conditional.ternary'] = {fg = langdefined},

    ['@keyword.directive']        = {fg = langdefined},
    ['@keyword.directive.define'] = {fg = langdefined},

    ['@punctuation.delimiter'] = {fg = ignorable},
    ['@punctuation.bracket']   = {fg = ignorable},
    ['@punctuation.special']   = {fg = ignorable},

    ['@comment']               = {fg = ignorable},
    ['@comment.documentation'] = {fg = ignorable},

    ['@comment.error']   = {link = '@comment'},
    ['@comment.warning'] = {link = '@comment'},
    ['@comment.todo']    = {link = '@comment'},
    ['@comment.note']    = {link = '@comment'},

    ['@markup.strong']        = {bold = true},
    ['@markup.italic']        = {italic = true},
    ['@markup.strikethrough'] = {strikethrough = true},
    ['@markup.underline']     = {underline = true},

    ['@markup.heading']   = {fg = heading, bold = true},
    ['@markup.heading.1'] = {fg = heading, bold = true},
    ['@markup.heading.2'] = {fg = heading, bold = true},
    ['@markup.heading.3'] = {fg = heading, bold = true},
    ['@markup.heading.4'] = {fg = heading, bold = true},
    ['@markup.heading.5'] = {fg = heading, bold = true},
    ['@markup.heading.6'] = {fg = heading, bold = true},

    ['@markup.quote'] = {fg = raw},
    ['@markup.math']  = {fg = raw},

    ['@markup.link']       = {fg = link, underline = true},
    ['@markup.link.label'] = {fg = link, underline = true},
    ['@markup.link.url']   = {fg = link, underline = true},

    ['@markup.raw']       = {fg = raw},
    ['@markup.raw.block'] = {fg = raw},

    ['@markup.list']           = {fg = list},
    ['@markup.list.checked']   = {fg = list},
    ['@markup.list.unchecked'] = {fg = list},

    ['@diff.plus']  = {fg = plus},
    ['@diff.minus'] = {fg = minus},
    ['@diff.delta'] = {fg = delta},

    ['@tag']           = {fg = userdefined},
    ['@tag.builtin']   = {fg = langdefined},
    ['@tag.attribute'] = {fg = userdefined},
    ['@tag.delimiter'] = {fg = langdefined},
}

vim.cmd.highlight('clear')

for name, opts in pairs(colorscheme) do
    vim.api.nvim_set_hl(0, name, opts)
end

---
--- Diagnostics
---

vim.diagnostic.config({signs = false})

---
--- Plugins
---

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},

    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',

    {'folke/neodev.nvim', opts = {}}
})

require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = {'lua_ls', 'clangd'},
    handlers = {
        function(client)
            require('lspconfig')[client].setup({})
        end,
    }
})

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client == nil then
            return
        end

        local function map(cap, mode, lhs, rhs)
            if client.supports_method(cap) then
                vim.keymap.set(mode, lhs, rhs, {buffer = args.buf})
            end
        end

        map('textDocument/definition', 'n',        'gd',        vim.lsp.buf.definition)
        map('textDocument/references', 'n',        '<Space>gr', vim.lsp.buf.references)
        map('textDocument/rename',     'n',        '<Space>lr', vim.lsp.buf.rename)
        map('textDocument/codeAction', {'n', 'v'}, '<Space>lc', vim.lsp.buf.code_action)
    end,
})
