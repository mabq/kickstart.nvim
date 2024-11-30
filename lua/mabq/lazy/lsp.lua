-- LSP facilitates features like go-to-definition, find references, hover, completion, rename, format, refactor, etc., using semantic whole-project analysis (unlike ctags).
-- `:h lsp`

return {
    {
        -- Pre-configured LPSs for most languages
        'neovim/nvim-lspconfig',
        dependencies = {
            -- Installs command-line tools to stdpath for Neovim
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            -- Shows LSP status updates
            'j-hui/fidget.nvim',
            -- Adds extra capabilities for LSP completions
            'hrsh7th/cmp-nvim-lsp',
            -- Symbol navigation
        },
        config = function()
            -- IMPORTANT! See `autocmd` file for lsp related keymaps...

            local cmp_lsp = require 'cmp_nvim_lsp'
            local capabilities = vim.tbl_deep_extend('force', {}, vim.lsp.protocol.make_client_capabilities(), cmp_lsp.default_capabilities())

            require('fidget').setup {}
            require('mason').setup()
            require('mason-lspconfig').setup {
                ensure_installed = {
                    -- `:h lspconfig-all` shows the list of all pre-configured LSPs by `nvim-lspconfig`
                    'lua_ls',
                    'rust_analyzer',
                    'gopls',
                },
                handlers = {
                    -- Here you can customize the config provided by `nvim-lspconfig` for each LSP

                    -- Default handler (add the extra lsp capabilities provided by `cmp-nvim-lsp`):
                    function(server_name)
                        require('lspconfig')[server_name].setup {
                            capabilities = capabilities,
                        }
                    end,

                    -- Zig handler:
                    -- zls = function()
                    --     local lspconfig = require 'lspconfig'
                    --     lspconfig.zls.setup {
                    --         root_dir = lspconfig.util.root_pattern('.git', 'build.zig', 'zls.json'),
                    --         settings = {
                    --             zls = {
                    --                 enable_inlay_hints = true,
                    --                 enable_snippets = true,
                    --                 warn_style = true,
                    --             },
                    --         },
                    --     }
                    --     vim.g.zig_fmt_parse_errors = 0
                    --     vim.g.zig_fmt_autosave = 0
                    -- end,

                    -- Lua handler:
                    ['lua_ls'] = function()
                        local lspconfig = require 'lspconfig'
                        lspconfig.lua_ls.setup {
                            capabilities = capabilities,
                            settings = {
                                Lua = {
                                    runtime = { version = 'Lua 5.1' },
                                    diagnostics = {
                                        globals = { 'bit', 'vim', 'it', 'describe', 'before_each', 'after_each' },
                                    },
                                },
                            },
                        }
                    end,
                },
            }
        end,
    },

    {
        'SmiteshP/nvim-navbuddy',
        dependencies = {
            'SmiteshP/nvim-navic',
            'MunifTanjim/nui.nvim',
        },
        opts = { lsp = { auto_attach = true } },
    },

    {
        -- TypeScript, better alternative to `ts-ls`
        -- Important! See https://github.com/pmizio/typescript-tools.nvim?tab=readme-ov-file#custom-user-commands for commands like `TSToolsRenameFile`
        'pmizio/typescript-tools.nvim',
        dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
        opts = {
            -- Support for styled-components
            tsserver_plugins = {
                '@styled/typescript-styled-plugin',
            },
        },
    },

    {
        -- LSP for Neovim config, runtime and plugins. Used for completion, annotations and signatures of Neovim apis.
        'folke/lazydev.nvim',
        dependencies = {
            {
                -- Meta type definitions for the Lua platform Luvit
                'Bilal2453/luvit-meta',
                lazy = true,
            },
        },
        ft = 'lua',
        opts = {
            library = {
                -- Load luvit types when the `vim.uv` word is found
                { path = 'luvit-meta/library', words = { 'vim%.uv' } },
            },
        },
    },
}
