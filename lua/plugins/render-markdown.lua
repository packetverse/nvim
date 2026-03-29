return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = "markdown",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.icons" },
  opts = {
    completions = {
      lsp = {
        enabled = true,
      },
    },
    heading = {
      sign = false,
      -- Required to look good with my mono font :(
      icons = { " 󰲡 ", " 󰲣 ", " 󰲥 ", " 󰲧 ", " 󰲩 ", " 󰲫 " },
    },
  },
}
