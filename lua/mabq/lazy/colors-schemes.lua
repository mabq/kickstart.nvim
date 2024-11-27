function ColorMyPencils(color)
  color = color or 'tokyonight'
  vim.cmd.colorscheme(color)
end

return {
  {
    'folke/tokyonight.nvim', -- edit some tokyonight colors
    -- use `config` (not `opts`) for customizations to work when calling `ColorMyPencils`
    config = function()
      require('tokyonight').setup {
        style = 'night', -- `storm`, `moon`, `night` or `day`
        -- Customize colors for `night` version
        on_highlights = function(hl, _)
          hl.CursorLine = {
            bg = '#1f202e', -- lighter contrast
          }
          hl.CursorColumn = {
            bg = '#1f202e', -- `:set cursorColumn!`
          }
          hl.ColorColumn = {
            bg = '#1f202e', -- `:colorcolumn=[value|empty]`
          }
          hl.Search = {
            bg = '#292E42', -- lighter constrast
            fg = '#c0caf5',
          }
          hl.LspReferenceRead = {
            bg = '#292E42', -- lighter constrast
          }
          hl.LspReferenceText = {
            bg = '#292E42',
          }
          hl.LspReferenceWrite = {
            bg = '#292E42',
          }
          hl.WinSeparator = {
            bold = true,
            fg = '#404464', -- lighter contrast
          }
        end,
      }
      ColorMyPencils()
    end,
  },

  {
    'rose-pine/neovim',
    name = 'rose-pine',
    config = function()
      ColorMyPencils()
    end,
  },
}
