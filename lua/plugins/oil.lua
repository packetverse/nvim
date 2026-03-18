return {
  "stevearc/oil.nvim",
  lazy = false,
  dependencies = {
    "nvim-mini/mini.icons",
    opts = {},
  },
  opts = {
    default_file_explorer = true,
    columns = { "icon" },
    keymaps = {
      ["<C-h>"] = "actions.toggle_hidden",
      ["<C-t>"] = "actions.toggle_trash",
      ["<C-c>"] = false,
      ["<C-k>"] = false,
      ["q"] = "actions.close",
      ["<C-f>"] = "actions.preview_scroll_down",
      ["<C-b>"] = "actions.preview_scroll_up",
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
      border = "rounded",
      win_options = {
        winhighlight = "FloatTitle:OilFloatTitle,FloatBorder:OilFloatBorder",
      },
      get_win_title = function()
        return (" %s "):format(vim.fn.fnamemodify(require("oil").get_current_dir(), ":~"))
      end,
      override = function(conf)
        conf.title = (" %s "):format(vim.fn.fnamemodify(require("oil").get_current_dir(), ":~"))
        conf.title_pos = "center"
        return conf
      end,
    },
    preview_win = {
      preview_method = "scratch",
      win_options = {
        winhighlight = "FloatTitle:OilPreviewTitle,FloatBorder:OilPreviewBorder",
      },
    },
  },
  keys = {
    {
      "-",
      function()
        require("oil").toggle_float()
      end,
      desc = "Open parent directory (float)",
    },
    {
      "<leader>-",
      "<CMD>Oil<CR>",
      desc = "Open parent directory",
    },
  },
}
