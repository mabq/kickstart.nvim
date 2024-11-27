-- `:help vim.keymap.set()`
-- `:h lua-guide-mappings`  - how to set keymappings in Lua
-- `:h map-modes`           - check modes table

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', 'Q', '<nop>')

vim.keymap.set('n', 'J', 'mzJ`z', { desc = 'Join line (without moving cursor)' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next (centered)' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Previous (centered)' })

vim.keymap.set('v', '<', '<gv') -- better indenting
vim.keymap.set('v', '>', '>gv')

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

--

vim.keymap.set('n', '<C-f>', ':silent !tmux neww $HOME/.config/tmux/scripts/tmux-sessionizer.sh<CR>', { desc = 'Tmux-sessionizer' })

vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Page down (centered)' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Page up (centered)' })

--

vim.keymap.set('n', '<A-j>', "<cmd>execute 'move .+' . v:count1<cr>==", { desc = 'Move Down' })
vim.keymap.set('n', '<A-k>', "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = 'Move Up' })
vim.keymap.set('i', '<A-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move Down' })
vim.keymap.set('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move Up' })
vim.keymap.set('v', '<A-j>', ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = 'Move Down' })
vim.keymap.set('v', '<A-k>', ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = 'Move Up' })

--

vim.g.mapleader = ' '

vim.keymap.set('x', '<leader>p', [["_dP]], { desc = 'Paste without yanking' })
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]], { desc = 'Yank to clipboard' })
vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]], { desc = 'Delete withou yanking' })

vim.keymap.set('n', '<leader>r', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
