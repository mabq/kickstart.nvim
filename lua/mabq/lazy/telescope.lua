-- `:help telescope`
-- `:help telescope.setup()`
-- `:checkhealth telescope`
--
-- While on Telescope, use `<c-/>` (insert mode) or `?` (normal mode) to open
-- a window that shows you all of the keymaps for the current Telescope picker

return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = 'make',
      -- `cond` is a condition used to determine whether this plugin should be installed and loaded.
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    {
      -- useful for getting pretty icons (requires a Nerd Font)
      'nvim-tree/nvim-web-devicons',
    },
  },
  config = function()
    require('telescope').setup {}

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')

    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Project git files' })
    vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Project files' })
    vim.keymap.set('n', '<leader>pb', builtin.buffers, { desc = 'Project buffers' })
    vim.keymap.set('n', '<leader>pw', function()
      local word = vim.fn.expand '<cword>'
      builtin.grep_string { search = word }
    end, { desc = 'Project word search' })
    vim.keymap.set('n', '<leader>pW', function()
      local word = vim.fn.expand '<cWORD>'
      builtin.grep_string { search = word }
    end, { desc = 'Project WORD search' })
    vim.keymap.set('n', '<leader>ps', function()
      builtin.grep_string { search = vim.fn.input 'Grep > ' }
    end, { desc = 'Project search' })

    vim.keymap.set('n', '<leader><leader>', builtin.resume, { desc = 'Telescope resume' })

    vim.keymap.set('n', '<leader>vh', builtin.help_tags, { desc = 'View help' })
    vim.keymap.set('n', '<leader>va', builtin.builtin, { desc = 'View all' })
  end,
}
