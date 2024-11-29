return {
    {
        -- Detect tabstop and shiftwidth automatically
        'tpope/vim-sleuth',
        config = function()
            -- IMPORTANT! If you ever need to work on a project where the
            -- formatter is configured to use tabs, edit and uncomment
            -- the following lines to match the desired tab-width.
            -- vim.opt.tabstop = 4
            vim.opt.expandtab = true
        end,
    },
}
