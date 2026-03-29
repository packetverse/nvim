return {
  "ph1losof/ecolog.nvim",
  branch = "v1",
  lazy = false,
  keys = {
    { "<leader>ge", "<CMD>EcologGoto<CR>", desc = "Go to ENV file" },
    { "<leader>ep", "<CMD>EcologPeek<CR>", desc = "Ecolog peek variable" },
    { "<leader>es", "<CMD>EcologSelect<CR>", desc = "Switch env file" },
  },
  opts = {
    integrations = {
      blink_cmp = true,
      lsp = false,
    },
    shelter = {
      configuration = {
        partial_mode = {
          show_start = 3,
          show_end = 3,
          min_mask = 3,
        },
        mask_char = "*",
        mask_length = nil,
        skip_comments = false,
      },
      modules = {
        -- mask no matter what to ensure no leaks occur
        cmp = true,
        peek = true,
        files = true,
        telescope = true,
        telescope_previewer = true,
        fzf = true,
        fzf_previewer = true,
        snacks_previewer = true,
        snacks = true,
      },
    },
    types = true,
    path = vim.fn.getcwd(),
  },
}
