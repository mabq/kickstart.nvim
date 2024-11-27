-- IMPORTANT!
-- Required for LSP actions, see mappings in the `autocmd` file

return {
    {
        'folke/trouble.nvim',
        opts = {
            focus = true,
        }, -- for default options, refer to the configuration section for custom setup.
        cmd = 'Trouble',
    },

    {
        'folke/todo-comments.nvim',
        cmd = { 'TodoTrouble' },
        opts = {},
        keys = {
            { '<leader>td', '<cmd>Trouble todo toggle<cr>', desc = 'Todo (Trouble)' },
        },
    },
}
