-- `:help vim.opt`
-- `:help option-list` - for more options

vim.opt.guicursor = ''

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.smartindent = true
-- options related to tab-width are set dynamically by the `sleuth` plugin

vim.opt.wrap = false
vim.opt.breakindent = true -- preserve indentation in wrapped text (when enabled)
vim.opt.linebreak = true -- do not break words when wrapping

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv 'HOME' .. '/.vim/undodir'
vim.opt.undofile = true

vim.opt.incsearch = true
vim.opt.hlsearch = true

vim.opt.cursorline = true
vim.opt.colorcolumn = '80'

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.isfname:append '@-@' -- adds `-` and `@` as filename characters

vim.opt.updatetime = 50

vim.opt.spelllang = { 'en', 'es' }

vim.opt.splitright = true
vim.opt.splitbelow = true

--  See `:help 'list'` and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '│ ', trail = '·', nbsp = '␣' }

-- vim.opt.showmode = false
