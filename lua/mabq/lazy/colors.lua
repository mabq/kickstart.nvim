function ColorMyPencils(color)
  color = color or 'rose-pine'
  vim.cmd.colorscheme(color)
  --
  -- vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
  -- vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
end

return {
  {
    'folke/tokyonight.nvim', -- edit some tokyonight colors
    -- use config (not opts) for customizations to work
    config = function()
      require('tokyonight').setup {
        style = 'night',
        -- transparent = true, -- enable this to disable setting the background color
        -- terminal_colors = true, -- configure the colors used when opening a `:terminal` in Neovim
        -- styles = {
        --   sidebars = 'normal', -- style for sidebars, see below
        --   floats = 'normal', -- style for floating windows
        -- },

        -- customize some colors
        on_colors = function(colors)
          colors.bg_hightlight = colors.yellow
        end,
        on_highlights = function(hl, _)
          hl.CursorLine = {
            bg = '#1f202e', -- much lighter contrast
          }
          hl.CursorLineNr = {
            bold = false, -- disabled bold
            fg = '#ff9e64',
          }
          hl.CursorColumn = {
            bg = '#1f202e', -- set it manually `:set cursorColumn!`
          }
          hl.ColorColumn = {
            bg = '#1f202e', -- set it manually with `:colorcolumn=[value|empty]`
          }
          hl.LspReferenceRead = {
            bg = '#292E42', -- much lighter contrast
          }
          hl.LspReferenceText = {
            bg = '#292E42',
          }
          hl.LspReferenceWrite = {
            bg = '#292E42',
          }
          hl.WinSeparator = {
            bold = true,
            fg = '#404464', -- much lighter contrast
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
      -- require('rose-pine').setup {
      --   disable_background = true,
      -- }
      ColorMyPencils()
    end,
  },
}
