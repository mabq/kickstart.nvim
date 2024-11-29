-- `:help vim.keymap.set()`
-- `:h lua-guide-mappings`  - how to set keymappings in Lua
-- `:h map-modes`           - check modes table

-- No special key:

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search hightlight' })
-- vim.keymap.set('n', 'Q', '<nop>', { desc = 'Disable Q default behavior' })

vim.keymap.set('n', 'J', 'mzJ`z', { desc = 'Join line (without moving cursor)' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next match (centered)' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Previous match (centered)' })

vim.keymap.set('v', '<', '<gv', { desc = 'Decrease indentation (keep selection)' })
vim.keymap.set('v', '>', '>gv', { desc = 'Increase indentation (keep selection)' })

vim.keymap.set('v', 'J', ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = 'Move line down' })
vim.keymap.set('v', 'K', ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = 'Move line up' })

vim.keymap.set('c', '<down>', function()
    if vim.fn.pumvisible() == 1 then
        return '<c-n>'
    end
    return '<down>'
end, { expr = true, desc = 'Select next menu item' })
vim.keymap.set('c', '<up>', function()
    if vim.fn.pumvisible() == 1 then
        return '<c-p>'
    end
    return '<up>'
end, { expr = true, desc = 'Select previous menu item' })

-- Ctrl --

vim.keymap.set('n', '<C-f>', ':silent !tmux neww $HOME/.config/tmux/scripts/tmux-sessionizer.sh<CR>', { desc = 'Run tmux-sessionizer' })

vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Page down (centered)' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Page up (centered)' })

-- Alt --

-- see vim-tmux-navigator

-- Leader

vim.g.mapleader = ' '

vim.keymap.set('x', '<leader>p', [["_dP]], { desc = 'Paste without yanking' })
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]], { desc = 'Yank to clipboard' })
vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]], { desc = 'Delete withou yanking' })

vim.keymap.set('n', '<leader>r', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
