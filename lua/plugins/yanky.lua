return {
  "gbprod/yanky.nvim",
  lazy = false,
  opts = {},
  keys = {
    { "p", "<Plug>(YankyPutAfter)<CR>" },
    { "P", "<Plug>(YankyPutBefore)<CR>" },
    { "gp", "<Plug>(YankyGPutAfter)<CR>" },
    { "gP", "<Plug>(YankyGPutBefore)<CR>" },

    { "<C-p>", "<Plug>(YankyPreviousEntry)<CR>" },
    { "<C-n>", "<Plug>(YankyNextEntry)<CR>" },
  },
}
