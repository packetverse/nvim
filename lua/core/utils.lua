local M = {}

function M.goto_buffer(n)
  local bufs = vim.fn.getbufinfo({ buflisted = 1 })
  if bufs[n] then
    vim.api.nvim_set_current_buf(bufs[n].bufnr)
  else
    return
  end
end

local maximized = {}

function M.toggle_maximize()
  local win = vim.api.nvim_get_current_win()

  if maximized[win] then
    vim.cmd("wincmd =")
    maximized[win] = nil
  else
    vim.cmd("wincmd _")
    vim.cmd("wincmd |")
    maximized[win] = true
  end
end

return M
