-- Disable auto comment continuation
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove("r")
    vim.opt_local.formatoptions:remove("o")
  end
})

-- Highlight yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({
      higroup = "Visual",
      timeout = 150,
    })
  end,
})

-- BUG: Seems to be not working as of now
-- Automatically reload config
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = vim.fn.stdpath("config") .. "/lua/**/*.lua",
  callback = function()
    local init_path = vim.fn.stdpath("config") .. "/init.lua"
    local ok, err = pcall(dofile, init_path)
    if not ok then
      print("Error reloading config: " .. err)
    else
      print("Config reloaded successfully!")
    end
  end
})

