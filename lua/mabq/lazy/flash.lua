return {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {
        -- https://github.com/folke/flash.nvim?tab=readme-ov-file#%EF%B8%8F-configuration
        modes = {
            search = {
                enabled = false, -- do not activate during regular search by default
            },
            char = {
                enabled = false, -- do not activate through `f`, `F`, `t`, `T`, `;` and `,` motions
            },
        },
    },
    keys = {
        {
            'f',
            mode = { 'n', 'x', 'o' },
            function()
                require('flash').jump()
            end,
            desc = 'Flash',
        },
        {
            'F',
            mode = { 'n', 'x', 'o' },
            function()
                require('flash').treesitter()
            end,
            desc = 'Flash treesitter',
        },
    },
}
