---
--- General settings
---

vim.opt.colorcolumn = {80}
vim.diagnostic.config({signs = false})

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

do
    local black = '#000000'
    local gray1 = '#c0c0c0'
    local gray2 = '#a0a0a0'
    local gray3 = '#808080'
    local gray4 = '#606060'

    local fg     = gray1
    local fg_alt = gray2
    local fg_rev = black
    local bg     = '#080404'
    local fg_dim = gray4
    local bg_dim = '#161010'

    local diff_added   = gray4
    local diff_changed = gray2
    local diff_deleted = gray1

    local hardcoded    = gray2
    local userdefined  = gray1
    local userdefined2 = gray3
    local langdefined  = gray4
    local ignorable    = gray4

    local heading = gray2
    local link    = gray2
    local raw     = gray4
    local list    = gray4

    local colorscheme = {
        -- :h highlight-default

        ['ColorColumn']    = {bg = bg_dim},
        ['Conceal']        = {fg = fg_dim},
        ['CurSearch']      = {fg = fg_rev, bg = fg_dim},
        ['Cursor']         = {link = 'CurSearch'},
        ['lCursor']        = {link = 'CurSearch'},
        ['CursorIM']       = {link = 'CurSearch'},
        ['CursorColumn']   = {link = 'ColorColumn'},
        ['CursorLine']     = {link = 'ColorColumn'},
        ['Directory']      = {fg = fg_alt},
        ['DiffAdd']        = {fg = fg_rev, bg = diff_added},
        ['DiffChange']     = {fg = fg_rev, bg = diff_changed},
        ['DiffDelete']     = {fg = fg_rev, bg = diff_deleted},
        ['DiffText']       = {reverse = true},
        ['EndOfBuffer']    = {link = 'Conceal'},
        ['TermCursor']     = {link = 'CurSearch'},
        ['TermCursorNC']   = {},
        ['ErrorMsg']       = {fg = fg_alt},
        ['WinSeparator']   = {link = 'Conceal'},
        ['Folded']         = {link = 'ColorColumn'},
        ['FoldColumn']     = {link = 'Conceal'},
        ['SignColumn']     = {link = 'Conceal'},
        ['IncSearch']      = {link = 'CurSearch'},
        ['Substitute']     = {link = 'CurSearch'},
        ['LineNr']         = {link = 'Conceal'},
        ['LineNrAbove']    = {link = 'Conceal'},
        ['LineNrBelow']    = {link = 'Conceal'},
        ['CursorLineNr']   = {link = 'CursorLine'},
        ['CursorLineFold'] = {link = 'CursorLine'},
        ['CursorLineSign'] = {link = 'CursorLine'},
        ['MatchParen']     = {link = 'CurSearch'},
        ['ModeMsg']        = {link = 'ErrorMsg'},
        ['MsgArea']        = {fg = fg},
        ['MsgSeparator']   = {link = 'ColorColumn'},
        ['MoreMsg']        = {link = 'ErrorMsg'},
        ['NonText']        = {link = 'Conceal'},
        ['Normal']         = {fg = fg, bg = bg},
        ['NormalFloat']    = {fg = fg, bg = bg_dim},
        ['FloatBorder']    = {link = 'NormalFloat'},
        ['FloatTitle']     = {fg = fg, bold = true},
        ['FloatFooter']    = {fg = fg, bold = true},
        ['NormalNC']       = {link = 'Normal'},
        ['Pmenu']          = {link = 'ColorColumn'},
        ['PmenuSel']       = {link = 'CurSearch'},
        ['PmenuKind']      = {link = 'Pmenu'},
        ['PmenuKindSel']   = {link = 'PmenuSel'},
        ['PmenuExtra']     = {link = 'Pmenu'},
        ['PmenuExtraSel']  = {link = 'PmenuSel'},
        ['PmenuSbar']      = {link = 'Pmenu'},
        ['PmenuThumb']     = {bg = fg_dim},
        ['Question']       = {link = 'ErrorMsg'},
        ['QuickFixLine']   = {link = 'ErrorMsg'},
        ['Search']         = {link = 'CurSearch'},
        ['SnippetTabstop'] = {link = 'ColorColumn'},
        ['SpecialKey']     = {link = 'Conceal'},
        ['SpellBad']       = {undercurl = true},
        ['SpellCap']       = {undercurl = true},
        ['SpellLocal']     = {undercurl = true},
        ['SpellRare']      = {undercurl = true},
        ['StatusLine']     = {fg = fg, bg = bg_dim},
        ['StatusLineNC']   = {fg = fg_dim, bg = bg_dim},
        ['TabLine']        = {link = 'StatusLineNC'},
        ['TabLineFill']    = {link = 'StatusLineNC'},
        ['TabLineSel']     = {link = 'StatusLine'},
        ['Title']          = {fg = fg, bold = true},
        ['Visual']         = {bg = bg_dim, bold = true},
        ['VisualNOS']      = {bg = bg_dim, bold = true},
        ['WarningMsg']     = {link = 'ErrorMsg'},
        ['Whitespace']     = {link = 'Conceal'},
        ['WildMenu']       = {link = 'CurSearch'},
        ['WinBar']         = {link = 'StatusLine'},
        ['WinBarNC']       = {link = 'StatusLineNC'},

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

        ['Error'] = {reverse = true},

        ['Todo'] = {bold = true},

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
        ['@module.builtin'] = {link = '@variable.builtin'},
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

        ['@function']         = {fg = userdefined2},
        ['@function.builtin'] = {fg = langdefined},
        ['@function.call']    = {fg = userdefined2},
        ['@function.macro']   = {fg = userdefined2},

        ['@function.method']      = {link = '@function'},
        ['@function.method.call'] = {link = '@function.call'},

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
        ['@markup.heading.2'] = {fg = heading},
        ['@markup.heading.3'] = {fg = heading},
        ['@markup.heading.4'] = {fg = heading},
        ['@markup.heading.5'] = {fg = heading},
        ['@markup.heading.6'] = {fg = heading},

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

        ['@diff.plus']  = {fg = diff_added},
        ['@diff.minus'] = {fg = diff_deleted},
        ['@diff.delta'] = {fg = diff_changed},

        ['@tag']           = {fg = userdefined},
        ['@tag.builtin']   = {fg = langdefined},
        ['@tag.attribute'] = {fg = userdefined},
        ['@tag.delimiter'] = {fg = langdefined},
    }

    vim.cmd.highlight('clear')

    for name, opts in pairs(colorscheme) do
        vim.api.nvim_set_hl(0, name, opts)
    end
end

---
--- Plugins
---

do
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
    --- @diagnostic disable-next-line
    vim.opt.rtp:prepend(lazypath)

    require('lazy').setup({
        {
            'nvim-treesitter/nvim-treesitter',
            build = ':TSUpdate',
            config = function()
                require('nvim-treesitter.configs').setup({
                    ensure_installed = {'lua', 'vimdoc', 'query', 'c'},
                    sync_install = false,
                    auto_install = true,
                    ignore_install = {},
                    modules = {},
                    highlight = {enable = true},
                    incremental_selection = {
                        enable = true,
                        keymaps = {
                            init_selection = '<C-M-j>',
                            node_incremental = '<C-M-j>',
                            scope_incremental = false,
                            node_decremental = '<C-M-k>',
                        },
                    },
                })
            end,
        },

        {
            'neovim/nvim-lspconfig',
            dependencies = {
                'williamboman/mason.nvim',
                'williamboman/mason-lspconfig.nvim',
                {'folke/neodev.nvim', opts = {}},
            },
            config = function()
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
            end,
        },
    })
end
