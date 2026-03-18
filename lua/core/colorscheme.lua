local M = {}

local persist_file = vim.fn.stdpath("state") .. "/colorscheme"

function M.set(name)
  if not name then
    return
  end

  vim.cmd.colorscheme(name)

  local f = io.open(persist_file, "w")
  if f then
    f:write(name)
    f:close()
  end
end

function M.load()
  local f = io.open(persist_file, "r")
  if f then
    local name = f:read("*l")
    f:close()
    if name then
      local ok = pcall(vim.cmd.colorscheme, name)
      if ok then
        return
      end
    end
  end

  vim.cmd.colorscheme("default")
end

return M
