return {
    {
        -- Detect tabstop and shiftwidth automatically
        'tpope/vim-sleuth',
        config = function()
            -- IMPORTANT! If you ever need to work on a project where the
            -- formatter is configured to use tabs, edit and uncomment
            -- the following lines to match the desired tab-width.
            -- vim.opt.tabstop = 4
            -- vim.opt.expandtab = false
        end,
    },

    {
        -- Automatically install formatter tools
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        config = function()
            require('mason-tool-installer').setup {
                ensure_installed = {
                    'biome',
                    'prettierd',
                    'stylua',
                },
            }
        end,
    },

    {
        -- enabled = false,
        'stevearc/conform.nvim',
        event = { 'BufWritePre' },
        cmd = { 'ConformInfo' },
        keys = {
            {
                '<leader>f',
                function()
                    require('conform').format { async = true, lsp_format = 'fallback' }
                end,
                mode = '',
            },
        },
        opts = {
            notify_on_error = true,
            format_on_save = function(bufnr)
                -- Disable "format_on_save lsp_fallback" for languages that don't
                -- have a well standardized coding style. You can add additional
                -- languages here or re-enable it for the disabled ones.
                local disable_filetypes = { c = true, cpp = true }
                local lsp_format_opt
                if disable_filetypes[vim.bo[bufnr].filetype] then
                    lsp_format_opt = 'never'
                else
                    lsp_format_opt = 'fallback'
                end
                return {
                    timeout_ms = 500,
                    lsp_format = lsp_format_opt,
                }
            end,
            formatters_by_ft = {
                lua = { 'stylua' },
                -- Conform can also run multiple formatters sequentially
                -- python = { "isort", "black" },

                -- You can use 'stop_after_first' to run the first available formatter from the list
                javascript = { 'biome', 'prettierd', stop_after_first = true },
                typescript = { 'biome', 'prettierd', stop_after_first = true },
            },
        },
    },
}
