return {
  "saghen/blink.cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    "disrupted/blink-cmp-conventional-commits",
    "moyiz/blink-emoji.nvim",
    "Kaiser-Yang/blink-cmp-git",
    "xzbdmw/colorful-menu.nvim",
  },
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
          columns = { { "kind_icon" }, { "label", gap = 1 } },
          components = {
            label = {
              text = function(ctx)
                return require("colorful-menu").blink_components_text(ctx)
              end,
              highlight = function(ctx)
                return require("colorful-menu").blink_components_highlight(ctx)
              end,
            },
          },
        },
      },
    },
    keymap = {
      preset = "none",
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "cancel", "fallback" },
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
      default = {
        "lsp",
        "buffer",
        "snippets",
        "path",
        "conventional_commits",
        "emoji",
        "lazydev",
        "git",
        "ecolog",
      },
      providers = {
        conventional_commits = {
          name = "Conventional Commits",
          module = "blink-cmp-conventional-commits",
          enabled = function()
            return vim.bo.filetype == "gitcommit"
          end,
        },
        emoji = {
          name = "Emoji",
          module = "blink-emoji",
          score_offset = 15,
          opts = {
            insert = true,
            trigger = function()
              return { ":" }
            end,
          },
          should_show_items = function()
            return vim.tbl_contains({ "gitcommit", "markdown" }, vim.o.filetype)
          end,
        },
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
        git = {
          name = "Git",
          module = "blink-cmp-git",
          enabled = function()
            return vim.tbl_contains({ "octo", "gitcommit", "markdown" }, vim.bo.filetype)
          end,
        },
        ecolog = {
          name = "Ecolog",
          module = "ecolog.integrations.cmp.blink_cmp",
        },
        -- cmdline = {
        --   min_keyword_length = function(ctx)
        --     if ctx.mode == "cmdline" and string.find(ctx.line, " ") then
        --       return 3
        --     end
        --     return 0
        --   end,
        -- },
      },
    },
  },
}
