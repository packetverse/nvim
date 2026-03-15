return {
  "saghen/blink.cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = { "rafamadriz/friendly-snippets" },
  build = "cargo build --release",
  opts = {
    signature = {
      enabled = true,
      window = {
        show_documentation = true,
      },
    },
    completion = {
      ghost_text = {
        enabled = false,
        show_with_menu = false,
      },
      menu = {
        auto_show = true, -- disable to use only ghost text
        draw = {
          -- nvim-cmp style
          -- columns = {
          --   { "label", "label_description", gap = 1 }, { "kind_icon", "kind" },
          -- },
          components = {
            kind_icon = {
              text = function(ctx)
                local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                return kind_icon
              end,
              highlight = function(ctx)
                local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                return hl
              end,
            },
            kind = {
              highlight = function(ctx)
                local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                return hl
              end,
            },
          },
        },
      },
    },
    keymap = {
      preset = "none",
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide", "fallback" },
      ["<C-y>"] = { "select_and_accept", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<CR>"] = { "select_and_accept", "fallback" },
      ["<C-s>"] = { "show_signature", "hide_signature", "fallback" },
      ["<C-u>"] = { "scroll_signature_up", "scroll_documentation_up", "fallback" },
      ["<C-d>"] = { "scroll_signature_down", "scroll_documentation_down", "fallback" },
      ["<M-l>"] = { "snippet_forward", "fallback" },
      ["<M-h>"] = { "snippet_backward", "fallback" },
      ["<C-h>"] = { "show_documentation", "hide_documentation", "fallback" },
    },
    cmdline = {
      keymap = {
        preset = "none",
        ["<Tab>"] = { "show_and_insert_or_accept_single", "select_next" },
        ["<S-Tab>"] = { "show_and_insert_or_accept_single", "select_prev" },
        ["<CR>"] = { "accept_and_enter", "fallback" },
        ["<C-space>"] = { "show", "show_documentation", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-y>"] = { "select_and_accept", "fallback" },
        ["<C-e>"] = { "cancel", "fallback" },
      },
      completion = {
        menu = {
          auto_show = true,
        },
        ghost_text = {
          enabled = false,
        },
      },
    },
    sources = {
      providers = {
        cmdline = {
          min_keyword_length = function(ctx)
            if ctx.mode == "cmdline" and string.find(ctx.line, " ") then
              return 3
            end
            return 0
          end,
        },
      },
    },
  },
}
