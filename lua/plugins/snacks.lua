return {
  "folke/snacks.nvim",
  lazy = false,
  dependencies = { "nvim-lua/plenary.nvim", "nvim-mini/mini.icons" },
  priority = 1000,
  opts = {
    bigfile = { enabled = false },
    dashboard = {
      enabled = true,
      preset = {
        -- stylua: ignore
        header = [[
      ████ ██████           █████      ██                    
     ███████████             █████                            
     █████████ ███████████████████ ███   ███████████  
    █████████  ███    █████████████ █████ ██████████████  
   █████████ ██████████ █████████ █████ █████ ████ █████  
 ███████████ ███    ███ █████████ █████ █████ ████ █████ 
██████  █████████████████████ ████ █████ █████ ████ ██████
]],
      },
      sections = {
        { padding = 0, align = "center", section = "header" },

        {
          title = "Builtin Actions",
          indent = 2,
          padding = 1,
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "r", desc = "Restore Session", section = "session" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },

        {
          title = "Maintenance Actions",
          indent = 2,
          padding = 2,
          {
            icon = " ",
            key = "c",
            desc = "Config",
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
        },
        { section = "startup" },
      },
    },
    explorer = {
      enabled = true,
      replace_netrw = false,
      trash = true,
    },
    image = { enabled = false },
    indent = {
      enabled = false,
      animate = {
        enabled = false,
      },
      scope = {
        only_current = true,
      },
    },
    input = { enabled = false },
    notifier = {
      enabled = true,
      style = "compact",
      margin = {
        top = 1,
      },
      icons = {
        error = "",
        warn = "",
        info = "",
        debug = "",
        trace = "",
      },
    },
    picker = {
      enabled = true,
      prompt = "  ",
      layout = {
        preset = function()
          return vim.o.columns >= 120 and "custom_picker" or "vertical"
        end,
      },
      layouts = {
        select = {
          layout = {
            wo = {
              winhighlight = "FloatBorder:SnacksPickerSelectBorder,FloatTitle:SnacksPickerSelectTitle",
            },
            hidden = { "preview" },
            backdrop = false,
            width = 0.5,
            min_width = 80,
            max_width = 100,
            height = 0.4,
            min_height = 2,
            box = "vertical",
            border = true,
            title = "{title}",
            title_pos = "center",
            {
              win = "input",
              height = 1,
              border = "bottom",
              wo = { winhighlight = "FloatBorder:SnacksPickerSelectInputBorder" },
            },
            { win = "list", border = "none" },
            {
              win = "preview",
              title = "{preview}",
              height = 0.4,
              border = "top",
              wo = { winhighlight = "SignColumn:SnacksPickerSelectSignColumn" },
            },
          },
        },
        custom_picker = {
          layout = {
            box = "horizontal",
            backdrop = 40,
            width = 0.9,
            height = 0.8,
            border = "none",
            {
              box = "vertical",
              width = 0,
              {
                win = "input",
                height = 1,
                border = "rounded",
                title = "Find {title} {live} {flags}",
                title_pos = "center",
              },
              { win = "list", border = "none" },
            },
            {
              win = "preview",
              title = "{preview:Preview}",
              title_pos = "center",
              width = 0.6,
              border = "rounded",
              wo = {
                winhighlight = "Normal:SnacksPickerPreview,FloatTitle:SnacksPickerPreviewTitle,FloatBorder:SnacksPickerPreviewBorder,SignColumn:SnacksPickerPreviewSignColumn",
              },
            },
          },
        },
      },
      sources = {
        explorer = {
          focus = "list",
          enter = false,
        },
      },
    },
    quickfile = { enabled = false },
    scope = { enabled = false },
    scroll = { enabled = false },
    statuscolumn = { enabled = false },
    words = {
      enabled = true,
    },
    zen = {
      enabled = true,
      toggles = {
        animate = false,
        dim = false,
        indent = false,
      },
      win = {
        style = "custom_zen",
      },
    },
    toggle = {
      notify = false,
    },
    styles = {
      float = {
        border = "none",
      },
      notification = {
        border = "single",
        wo = {
          winblend = 0,
        },
      },
      notification_history = {
        wo = {
          winhighlight = "Normal:SnacksNotifierHistory,FloatTitle:SnacksNotifierHistoryBorderTitle,FloatBorder:SnacksNotifierHistoryBorder",
        },
      },
      custom_zen = {
        enter = true,
        fixbuf = false,
        minimal = false,
        width = 120,
        height = 0,
        zindex = 60,
        backdrop = {
          transparent = false,
          blend = 0,
          win = {
            wo = {
              winhighlight = "Normal:SnacksZenBackdrop,FloatBorder:FloatBorder",
            },
          },
        },
        keys = { q = false },
      },
    },
  },
  keys = {
    {
      "<leader>uC",
      function()
        require("snacks").picker.colorschemes({
          preview = false,
          confirm = function(picker, item)
            picker:close()
            if item then
              vim.schedule(function()
                require("core.colorscheme").set(item.text)
              end)
            end
          end,
        })
      end,
      desc = "Change colorschemes",
    },

    -- toggles
    {
      "<leader>uL",
      function()
        require("snacks").toggle.option("relativenumber", { name = "Relative number" }):toggle()
      end,
      desc = "Toggle relative line number",
    },
    {
      "<leader>ub",
      function()
        require("snacks").toggle.option("background", { off = "light", on = "dark", name = "Dark background" }):toggle()
      end,
      desc = "Toggle dark background",
    },
    {
      "<leader>ug",
      function()
        require("snacks").toggle.indent():toggle()
      end,
      desc = "Toggle indent",
    },
    {
      "<leader>ul",
      function()
        require("snacks").toggle.line_number():toggle()
      end,
      desc = "Toggle line number",
    },
    {
      "<leader>uh",
      function()
        require("snacks").toggle.inlay_hints():toggle()
      end,
      desc = "Toggle inlay hints",
    },
    {
      "<leader>uw",
      function()
        require("snacks").toggle.words():toggle()
      end,
      desc = "Toggle words",
    },

    -- ui
    {
      "<leader>un",
      function()
        require("snacks").notifier.show_history()
      end,
      desc = "Toggle notification history",
    },
    {
      "<leader>z",
      function()
        require("snacks").zen()
      end,
      desc = "Toggle zen mode",
    },
    {
      "<leader>e",
      function()
        require("snacks").explorer()
      end,
      desc = "Toggle explorer",
    },
    {
      "<leader>t",
      function()
        require("snacks").terminal()
      end,
      nowait = true,
      desc = "Toggle floating terminal",
    },

    -- find
    {
      "<leader><space>",
      function()
        require("snacks").picker.smart()
      end,
      desc = "Smart find files",
    },
    {
      "<leader>fb",
      function()
        require("snacks").picker.buffers()
      end,
      desc = "Find buffers",
    },
    {
      "<leader>ff",
      function()
        require("snacks").picker.files()
      end,
      desc = "Find files",
    },
    {
      "<leader>fc",
      function()
        require("snacks").picker.files({ cwd = vim.fn.stdpath("config") })
      end,
      desc = "Find config files",
    },
    {
      "<leader>fr",
      function()
        require("snacks").picker.recent()
      end,
      desc = "Find recent files",
    },

    -- git
    {
      "<leader>gb",
      function()
        require("snacks").picker.git_branches()
      end,
      desc = "Git branches",
    },
    {
      "<leader>gl",
      function()
        require("snacks").picker.git_log()
      end,
      desc = "Git log",
    },
    {
      "<leader>gL",
      function()
        require("snacks").picker.git_log_line()
      end,
      desc = "Git log line",
    },
    {
      "<leader>gs",
      function()
        require("snacks").picker.git_status()
      end,
      desc = "Git status",
    },
    {
      "<leader>gS",
      function()
        require("snacks").picker.git_stash()
      end,
      desc = "Git stash",
    },
    {
      "<leader>gd",
      function()
        require("snacks").picker.git_diff()
      end,
      desc = "Git diff (hunks)",
    },
    {
      "<leader>gf",
      function()
        require("snacks").picker.git_log_file()
      end,
      desc = "Git log file",
    },

    -- grep
    {
      "<leader>sg",
      function()
        require("snacks").picker.grep()
      end,
      desc = "Grep",
    },

    -- search
    {
      "<leader>s/",
      function()
        require("snacks").picker.search_history()
      end,
      desc = "Search history",
    },
    {
      "<leader>sa",
      function()
        require("snacks").picker.autocmds()
      end,
      desc = "Autocommands",
    },
    {
      "<leader>sc",
      function()
        require("snacks").picker.command_history()
      end,
      desc = "Command history",
    },
    {
      "<leader>sd",
      function()
        require("snacks").picker.diagnostics()
      end,
      desc = "Diagnostics",
    },
    {
      "<leader>sD",
      function()
        require("snacks").picker.diagnostics_buffer()
      end,
      desc = "Diagnostics (buffer)",
    },
    {
      "<leader>sH",
      function()
        require("snacks").picker.highlights()
      end,
      desc = "Highlights",
    },
    {
      "<leader>sk",
      function()
        require("snacks").picker.keymaps()
      end,
      desc = "Search keymaps",
    },

    -- lsps
    {
      "gd",
      function()
        require("snacks").picker.lsp_definitions()
      end,
      desc = "[LSP] Goto definition",
    },
    {
      "gD",
      function()
        require("snacks").picker.lsp_declarations()
      end,
      desc = "[LSP] Goto declaration",
    },
    {
      "gr",
      function()
        require("snacks").picker.lsp_references()
      end,
      nowait = true,
      desc = "[LSP] References",
    },
    {
      "gI",
      function()
        require("snacks").picker.lsp_implementations()
      end,
      desc = "[LSP] Goto implementation",
    },
    {
      "<leader>ss",
      function()
        require("snacks").picker.lsp_symbols()
      end,
      desc = "[LSP] Symbols",
    },
    {
      "<leader>sS",
      function()
        require("snacks").picker.lsp_workspace_symbols()
      end,
      desc = "[LSP] Workspace symbols",
    },

    -- misc
    {
      "<leader>j",
      function()
        require("snacks").words.jump(vim.v.count1, true)
      end,
      desc = "Jump word forward",
    },
    {
      "<leader>k",
      function()
        require("snacks").words.jump(-vim.v.count1, true)
      end,
      desc = "Jump word backward",
    },
  },
}
