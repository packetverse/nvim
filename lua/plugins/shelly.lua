return {
  enabled = true,
  event = "VeryLazy",
  "packetverse/shelly.nvim",
  opts = {},
  keys = {
    {
      "<leader>us",
      function()
        require("shelly").picker()
      end,
      desc = "Shelly picker",
    },
  },
}
