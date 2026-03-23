return {
  enabled = true,
  lazy = false,
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
