return {
    -- LSP
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            -- Mason can install LSPs and related tools to stdpath for Neovim
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            -- Useful status updated for LSP
            'j-hui/fidget.nvim',
            -- Extra LSP completion capabilities
            'hrsh7th/cmp-nvim-lsp',
            -- Completion plugins
            'hrsh7th/nvim-cmp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
        },

        config = function()
            local improved_capabilities =
                vim.tbl_deep_extend('force', {}, vim.lsp.protocol.make_client_capabilities(), require('cmp_nvim_lsp').default_capabilities())

            local servers = {
                -- see `:help lspconfig-all` for a list of all the pre-configured LSPs
                gopls = {},
                rust_analyzer = {},
                ts_ls = {}, -- (use `typescript-tools` for styled-components support)
                lua_ls = {
                    -- cmd = {...},
                    -- filetypes = { ...},
                    -- capabilities = {},
                    settings = {
                        Lua = {
                            completion = {
                                callSnippet = 'Replace',
                            },
                            -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                            -- diagnostics = { disable = { 'missing-fields' } },
                        },
                    },
                },
            }

            require('fidget').setup {}
            require('mason').setup()
            require('mason-lspconfig').setup {
                ensure_installed = vim.tbl_keys(servers or {}),
                handlers = {
                    function(server_name)
                        local server = servers[server_name] or {}
                        -- This handles overriding only values explicitly passed
                        -- by the server configuration above. Useful when disabling
                        -- certain features of an LSP (for example, turning off formatting for ts_ls)
                        server.capabilities = vim.tbl_deep_extend('force', {}, improved_capabilities, server.capabilities or {})
                        require('lspconfig')[server_name].setup(server)
                    end,
                },
            }

            -- Create keybindings when LSP attaches
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('mabq-lsp-attach', { clear = true }),
                callback = function(e)
                    local opts = { buffer = e.buf }
                    vim.keymap.set('n', 'gd', function()
                        vim.lsp.buf.definition()
                    end, opts)
                    vim.keymap.set('n', 'K', function()
                        vim.lsp.buf.hover()
                    end, opts)
                    vim.keymap.set('n', '<leader>vws', function()
                        vim.lsp.buf.workspace_symbol()
                    end, opts)
                    vim.keymap.set('n', '<leader>vca', function()
                        vim.lsp.buf.code_action()
                    end, opts)
                    vim.keymap.set('n', '<leader>vre', function()
                        vim.lsp.buf.references()
                    end, opts)
                    vim.keymap.set('n', '<leader>rn', function()
                        vim.lsp.buf.rename()
                    end, opts)
                    vim.keymap.set('i', '<C-h>', function()
                        vim.lsp.buf.signature_help()
                    end, opts)
                    vim.keymap.set('n', '<leader>vd', function()
                        vim.diagnostic.open_float()
                    end, opts)
                    vim.keymap.set('n', '[d', function()
                        vim.diagnostic.goto_next()
                    end, opts)
                    vim.keymap.set('n', ']d', function()
                        vim.diagnostic.goto_prev()
                    end, opts)
                end,
            })

            -- Auto-completion and snippets
            local cmp = require 'cmp'
            local cmp_select = { behavior = cmp.SelectBehavior.Select }

            cmp.setup {
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                    end,
                },
                mapping = cmp.mapping.preset.insert {
                    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                    ['<C-y>'] = cmp.mapping.confirm { select = true },
                    ['<C-Space>'] = cmp.mapping.complete(),
                },
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' }, -- For luasnip users.
                }, {
                    { name = 'buffer' },
                }),
            }

            vim.diagnostic.config {
                -- update_in_insert = true,
                float = {
                    focusable = false,
                    style = 'minimal',
                    border = 'rounded',
                    source = 'always',
                    header = '',
                    prefix = '',
                },
            }
        end,
    },
}
