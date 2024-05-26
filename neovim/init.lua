vim.api.nvim_create_user_command('EditorConfig', function()
    vim.cmd('tabedit .editorconfig')
    if vim.fn.findfile('.editorconfig') == '' then
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
                ensure_installed = {'lua', 'vimdoc', 'query'},
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
                },
            })

            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('initlua_lsp', {}),
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

                    map('textDocument/definition',    'n',        'gd',        vim.lsp.buf.definition)
                    map('textDocument/references',    'n',        '<Space>gr', vim.lsp.buf.references)
                    map('textDocument/rename',        'n',        '<Space>lr', vim.lsp.buf.rename)
                    map('textDocument/codeAction',    {'n', 'v'}, '<Space>lc', vim.lsp.buf.code_action)
                    map('textDocument/signatureHelp', 'i',        '<C-Space>', vim.lsp.buf.signature_help)
                end,
            })
        end,
    },

    {
        'NeogitOrg/neogit',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'sindrets/diffview.nvim',
        },
        config = true,
    },
}, {
    change_detection = {enabled = false},
    install = {colorscheme = {'default'}},
})
