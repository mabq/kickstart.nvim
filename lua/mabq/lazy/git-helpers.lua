-- `:checkhealth snacks`

return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      lazygit = { enabled = true },
    },
    keys = {
      {
        '<leader>gg',
        function()
          Snacks.lazygit()
        end,
        desc = 'Lazygit',
      },
      {
        '<leader>gu',
        function()
          Snacks.terminal { 'gitui' }
        end,
        desc = 'GitUi (cwd)',
      },
    },
  },
}
