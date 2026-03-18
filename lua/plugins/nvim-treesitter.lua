return {
  enabled = false,
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  build = ":TSUpdate",
  config = function()
    local nvim_treesitter = require("nvim-treesitter.configs")

    -- vim.notify helper
    -- local function echo_status(msg, timeout_ms)
    --   vim.api.nvim_echo({ { msg, "Normal" } }, false, {})
    --
    --   vim.defer_fn(function()
    --     vim.api.nvim_echo({ { "", "Normal" } }, false, {})
    --   end, timeout_ms or 3000)
    -- end

    -- vars
    -- local data_path = vim.fn.stdpath("data")
    -- local config_path = vim.fn.stdpath("data")
    --
    -- local parser_src = data_path .. "/site/parser"
    -- local parser_dst = config_path .. "/parser"
    --
    -- local queries_src = data_path .. "/lazy/nvim-treesitter/queries"
    -- local queries_dst = config_path .. "/queries"
    --
    -- local parser_info_path = config_path .. "/parser-info"

    local langs = {
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

    nvim_treesitter.setup({
      ensure_installed = langs,
    })

    -- vim.api.nvim_create_autocmd("VimEnter", {
    --   once = true,
    --   callback = function()
    --     require("nvim-treesitter.install").update({ with_sync = true })
    --
    --     -- copy helper
    --     local function copy_file(src, dst)
    --       local data = vim.fn.readfile(src, "b")
    --       vim.fn.writefile(data, dst, "b")
    --     end
    --
    --     -- copy parsers
    --     vim.fn.mkdir(parser_dst, "p")
    --     for _, f in ipairs(vim.fn.readdir(parser_src)) do
    --       copy_file(parser_src .. "/" .. f, parser_dst .. "/" .. f)
    --     end
    --
    --     -- copy queries
    --     for _, lang in ipairs(langs) do
    --       local src = queries_src .. "/" .. lang
    --       local dst = queries_dst .. "/" .. lang
    --       if vim.fn.isdirectory(src) == 1 then
    --         vim.fn.mkdir(dst, "p")
    --         for _, f in ipairs(vim.fn.readdir(src)) do
    --           copy_file(src .. "/" .. f, dst .. "/" .. f)
    --         end
    --       end
    --     end
    --
    --     -- remove parser-info dir
    --     if vim.fn.isdirectory(parser_info_path) == 1 then
    --       vim.fn.delete(parser_info_path, "rf")
    --     end
    --   end
    -- })
    --
    -- echo_status("Treesitter bootstrap complete. Safe to exit.", vim.log.levels.INFO)
  end,
}
