return {
  "stevearc/oil.nvim",
  lazy = false,
  dependencies = {
    "nvim-mini/mini.icons", opts = {},
  },
  opts = {
    default_file_explorer = true,
    columns = { "icon" },
    keymaps = {
      ["<C-h>"] = false,
      ["<C-c>"] = false,
      ["<M-h>"] = "actions.select_split",
      ["q"] = "actions.close",
    },
    delete_to_trash = true,
    view_options = {
      show_hidden = true,
    },
    skip_confirm_for_simple_edits = true,
    watch_for_changes = true,
    float = {
      max_width = 0.8,
      max_height = 0.8,
      border = "single",
    }
  },
  keys = {
    { "-", function() require("oil").toggle_float() end, desc = "Open parent directory" }
  },
}
