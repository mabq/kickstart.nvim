-- The counter part of this config file is tmux keybindings
vim.g.tmux_navigator_no_mappings = 1

return {
    'christoomey/vim-tmux-navigator',
    cmd = {
        'TmuxNavigateLeft',
        'TmuxNavigateDown',
        'TmuxNavigateUp',
        'TmuxNavigateRight',
        'TmuxNavigatePrevious',
    },
    keys = {
        -- Ctrl keys are used for harpoon
        { '<M-h>', '<cmd>TmuxNavigateLeft<cr>' },
        { '<M-j>', '<cmd>TmuxNavigateDown<cr>' },
        { '<M-k>', '<cmd>TmuxNavigateUp<cr>' },
        { '<M-l>', '<cmd>TmuxNavigateRight<cr>' },
    },
}
