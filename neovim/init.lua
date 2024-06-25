local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup({
                ensure_installed = {'lua', 'vimdoc', 'c'},
                sync_install = false,
                auto_install = true,
                ignore_install = {},
                modules = {},
                highlight = {enable = true},
            })
        end,
    },

    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',

            {
                'folke/lazydev.nvim',
                ft = 'lua',
                opts = {
                    library = {
                        {path = 'luvit-meta/library', words = {'vim%.uv'}},
                    },
                },
            },
            {'Bilal2453/luvit-meta', lazy = true},
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
})
