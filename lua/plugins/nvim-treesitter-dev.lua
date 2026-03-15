return {
  enabled = false,
  "nvim-treesitter-dev",
  dir = "~/projects/nvim-treesitter",
  opts = {
    install_dir = vim.fn.stdpath("config"),
    ensure_installed = {
      "bash",
      "comment",
      "dockerfile",
      "gitignore",
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
  }
}
