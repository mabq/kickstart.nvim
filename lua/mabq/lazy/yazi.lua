return {
    'rolv-apneseth/tfm.nvim',
    name = 'yazi (tfm.nvim)',
    lazy = false,
    opts = {
        file_manager = 'yazi',
        replace_netrw = false,
        enable_cmds = true,
        ui = {
            border = 'rounded',
            height = 0.8,
            width = 0.9,
            x = 0.5,
            y = 0.5,
        },
    },
    keys = {
        { '<leader>e', '<cmd>Tfm<cr>', desc = 'Explore (yazi)' },
    },
}
