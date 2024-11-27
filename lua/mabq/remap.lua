-- `:help vim.keymap.set()`
-- `:h lua-guide-mappings`  - how to set keymappings in Lua
-- `:h map-modes`           - check modes table

vim.g.mapleader = ' '

vim.keymap.set('n', '<C-f>', ':silent !tmux neww $HOME/.config/tmux/scripts/tmux-sessionizer.sh<CR>', { desc = 'Tmux-sessionizer' })

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move line down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move line up' })

vim.keymap.set('n', 'J', 'mzJ`z', { desc = 'Join line (without moving cursor)' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Page down (centered)' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Page up (centered)' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next (centered)' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Previous (centered)' })
-- vim.keymap.set('n', '<leader>zig', '<cmd>LspRestart<cr>')

vim.keymap.set('x', '<leader>p', [["_dP]], { desc = 'Paste without yanking' })
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]], { desc = 'Yank to clipboard' })
vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]], { desc = 'Delete withou yanking' })

vim.keymap.set('n', '<leader>r', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- move through popup options with up/down arrows
vim.keymap.set('c', '<down>', function()
    if vim.fn.pumvisible() == 1 then
        return '<c-n>'
    end
    return '<down>'
end, { expr = true })
vim.keymap.set('c', '<up>', function()
    if vim.fn.pumvisible() == 1 then
        return '<c-p>'
    end
    return '<up>'
end, { expr = true })

-- easier split navigation (used by harpoon now)
-- vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
-- vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
-- vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
-- vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
