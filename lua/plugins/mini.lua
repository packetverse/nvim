return {
  {
    "nvim-mini/mini.surround",
    version = false,
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },
  {
    "nvim-mini/mini.pairs",
    version = false,
    event = "InsertEnter",
    opts = {},
  },
  {
    "nvim-mini/mini.tabline",
    event = "VeryLazy",
    dependencies = { "nvim-mini/mini.icons" },
    version = false,
    opts = {},
  },
  {
    enabled = true,
    "nvim-mini/mini.statusline",
    event = "VeryLazy",
    dependencies = { "nvim-mini/mini.icons" },
    version = false,
    config = function()
      _G.macro_recording = ""

      local MiniStatusline = require("mini.statusline")

      vim.api.nvim_create_autocmd("RecordingEnter", {
        callback = function()
          _G.macro_recording = "Recording @" .. vim.fn.reg_recording()
          vim.cmd("redrawstatus")
        end,
      })

      vim.api.nvim_create_autocmd("RecordingLeave", {
        callback = function()
          _G.macro_recording = ""
          vim.cmd("redrawstatus")
        end,
      })

      MiniStatusline.setup({
        content = {
          active = function()
            local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
            local git = MiniStatusline.section_git({ trunc_width = 40 })
            local diff = MiniStatusline.section_diff({ trunc_width = 75 })
            local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
            local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
            local filename = MiniStatusline.section_filename({ trunc_width = 140 })
            local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
            local location = MiniStatusline.section_location({ trunc_width = 75 })
            local search = MiniStatusline.section_searchcount({ trunc_width = 75 })
            local macro = _G.macro_recording

            return MiniStatusline.combine_groups({
              { hl = mode_hl, strings = { mode:gsub("(%a)[^%-]*%-?", "%1") } },
              { hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics, lsp } },
              "%<", -- Mark general truncate point
              { hl = "MiniStatuslineFilename", strings = { filename } },
              "%=", -- End left alignment
              { hl = "MiniStatuslineFileinfo", strings = { macro } },
              { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
              { hl = mode_hl, strings = { search, location } },
            })
          end,
        },
      })
    end,
  },
  {
    enabled = true,
    "nvim-mini/mini.sessions",
    version = false,
    opts = {
      autoread = false,
      autowrite = true,
    },
    keys = {
      {
        "<leader>qs",
        function()
          ---@diagnostic disable: undefined-field
          require("mini.sessions").write(vim.fn.fnamemodify(vim.loop.cwd(), ":t"))
        end,
        "Save session (cwd name)",
      },
      {
        "<leader>qS",
        function()
          local name = vim.fn.input("Session name: ")
          if name ~= "" then
            require("mini.sessions").write(name)
          end
        end,
        "Save session as...",
      },
      {
        "<leader>qr",
        function()
          require("mini.sessions").select()
        end,
        "Restore session",
      },
      {
        "<leader>qd",
        function()
          require("mini.sessions").select("delete")
        end,
        "Delete session",
      },
    },
  },
  {
    enabled = false,
    "nvim-mini/mini.jump",
    version = false,
    event = "VeryLazy",
    config = function()
      local mini_jump = require("mini.jump")

      mini_jump.setup({
        delay = {
          highlight = 50,
          idle_stop = 2000,
        },
        silent = false,
      })

      local jump_stop = function()
        if not mini_jump.state.jumping then
          return "<Esc>"
        end
        mini_jump.stop_jumping()
      end
      local opts = { expr = true, desc = "Stop jumping" }
      vim.keymap.set({ "n", "x", "o" }, "<Esc>", jump_stop, opts)
    end,
  },
  {
    enabled = true,
    "nvim-mini/mini.jump2d",
    version = false,
    keys = { "<CR>" },
    config = function()
      local mini_jump2d = require("mini.jump2d")

      mini_jump2d.setup({
        view = {
          dim = true,
          n_steps_ahead = 2,
        },
        silent = true,
      })

      vim.keymap.set(
        { "o", "x", "n" },
        "<CR>",
        "<CMD>lua MiniJump2d.start(MiniJump2d.builtin_opts.single_character)<CR>",
        { desc = "Jump anywhere" }
      )
    end,
  },
  {
    enabled = true,
    "nvim-mini/mini.diff",
    event = { "BufReadPost", "BufNewFile" },
    version = false,
    opts = {
      view = {
        style = "sign",
        signs = {
          add = "▎",
          change = "▎",
          delete = "▎",
        },
      },
    },
  },
  {
    enabled = false,
    "nvim-mini/mini-git",
    version = false,
    opts = {},
  },
}
