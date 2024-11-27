return {
    {
        -- Yazi
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
    },

    {
        'ThePrimeagen/harpoon',
        branch = 'harpoon2',
        config = function()
            local harpoon = require 'harpoon'

            harpoon:setup {
                menu = {
                    width = vim.api.nvim_win_get_width(0) - 4,
                },
                settings = {
                    save_on_toggle = true,
                },
            }

            vim.keymap.set('n', '<leader>A', function()
                harpoon:list():prepend()
            end)
            vim.keymap.set('n', '<leader>a', function()
                harpoon:list():add()
            end)

            vim.keymap.set('n', '<C-e>', function()
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end)

            vim.keymap.set('n', '<C-h>', function()
                harpoon:list():select(1)
            end)
            vim.keymap.set('n', '<C-j>', function()
                harpoon:list():select(2)
            end)
            vim.keymap.set('n', '<C-k>', function()
                harpoon:list():select(3)
            end)
            vim.keymap.set('n', '<C-l>', function()
                harpoon:list():select(4)
            end)
            vim.keymap.set('n', '<leader><C-h>', function()
                harpoon:list():replace_at(1)
            end)
            vim.keymap.set('n', '<leader><C-j>', function()
                harpoon:list():replace_at(2)
            end)
            vim.keymap.set('n', '<leader><C-k>', function()
                harpoon:list():replace_at(3)
            end)
            vim.keymap.set('n', '<leader><C-l>', function()
                harpoon:list():replace_at(4)
            end)
        end,
    },
}
