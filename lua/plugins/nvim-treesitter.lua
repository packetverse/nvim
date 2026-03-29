return {
  enabled = true,
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local langs = {
      "bash",
      "comment",
      "dockerfile",
      "gitignore",
      "html",
      "json",
      "lua",
      "markdown",
      "markdown_inline",
      "vim",
      "vimdoc",
      "regex",
      "rust",
      "python",
    }

    ---@diagnostic disable: missing-fields
    require("nvim-treesitter.configs").setup({
      ensure_installed = langs,
      sync_install = false,
      auto_install = false,
      ignore_install = {},
      highlight = {
        enable = true,
        ---@diagnostic disable-next-line: unused-local
        disable = function(lang, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          ---@diagnostic disable-next-line: undefined-field
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
      },
      indent = {
        enable = true,
      },
    })
  end,
}
