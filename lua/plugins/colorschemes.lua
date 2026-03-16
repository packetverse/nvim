return {
  {
    "sainnhe/gruvbox-material",
    lazy = true,
    priority = 1000,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    priority = 1000,
    opts = {
      custom_highlights = function(c)
        return {
          SnacksPickerInput = { bg = c.base },
          SnacksPickerInputBorder = { bg = c.base, fg = c.base },
          SnacksPickerInputTitle = { bg = c.mauve, fg = c.surface0 },

          SnacksPickerPreview = { bg = c.mantle },
          SnacksPickerPreviewBorder = { bg = c.mantle, fg = c.mantle },
          SnacksPickerPreviewTitle = { bg = c.sky, fg = c.surface0 },
          SnacksPickerPreviewSignColumn = { bg = c.mantle },
        }
      end,
    },
  },
  {
    "projekt0n/github-nvim-theme",
    lazy = true,
    priority = 1000,
  },
  {
    "rose-pine/neovim",
    lazy = true,
    priority = 1000,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    priority = 1000,
  },
  {
    "EdenEast/nightfox.nvim",
    lazy = true,
    priority = 1000,
  },
  {
    "sainnhe/everforest",
    lazy = true,
    priority = 1000,
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    priority = 1000,
    opts = {
      on_highlights = function(hl, c)
        hl.SnacksPickerInput = { bg = c.bg }
        hl.SnacksPickerInputBorder = { bg = c.bg, fg = c.bg }
        hl.SnacksPickerInputTitle = { bg = c.purple, fg = c.fg_gutter }
        hl.SnacksPickerPreview = { bg = c.bg_float }
        hl.SnacksPickerPreviewBorder = { bg = c.bg_float, fg = c.bg_float }
        hl.SnacksPickerPreviewTitle = { bg = c.orange, fg = c.fg_gutter }
        hl.SnacksPickerSignColumn = { bg = c.bg_float, fg = c.bg_float }

        hl.MiniJump2dSpot = { fg = c.orange, bg = c.bg_float, bold = true }
        hl.MiniJump2dSpotUnique = { fg = c.green, bg = c.bg_float, bold = true }
        hl.MiniJump2dSpotAhead = { fg = c.blue, bg = c.bg_float }
        hl.MiniJump2dDim = { fg = c.comment }
      end,
    },
  },
}
