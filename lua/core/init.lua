---@class KeymapOpts
---@field noremap boolean
---@field silent boolean
---@field desc string?

local M = {}

---@type KeymapOpts
M.default_opts = { noremap = true, silent = true }

---Helper: vim.keymap wrapper that helps set a keymap easier
---@param mode string|string[] Mode(s) in which to set the keymap (e.g., "n", "i", { "n", "v" })
---@param lhs string
---@param rhs fun()|string
---@param desc string?
---@param opts KeymapOpts?
function M.keymap(mode, lhs, rhs, desc, opts)
  local final_opts = vim.tbl_extend("force", M.default_opts, opts or {})
  final_opts.desc = desc or lhs
  vim.keymap.set(mode, lhs, rhs, final_opts)
end

---Helper: Wraps keymap function but allows for range
---@param mode string|string[] Mode(s) in which to set the keymap (e.g., "n", "i", { "n", "v" })
---@param start_idx integer
---@param end_idx integer
---@param keys string|fun(i:integer):string
---@param action fun(i:integer)
---@param desc_prefix string?
function M.keymap_range(mode, start_idx, end_idx, keys, action, desc_prefix)
  for i = start_idx, end_idx do
    local lhs = type(keys) == "function" and keys(i) or tostring(keys)
    local desc = desc_prefix and (desc_prefix .. " " .. i) or lhs
    M.keymap(mode, lhs, function() action(i) end, desc)
  end
end

---Helper: Go to nth buffer, doesn't work hidden buffers
---@param n integer
function M.go_to_buffer(n)
  local bufs = vim.fn.getbufinfo({ buflisted = 1 })
  if bufs[n] then
    vim.api.nvim_set_current_buf(bufs[n].bufnr)
  else
    print("Buffer " .. n .. " does not exist")
  end
end

---@type table<number, boolean>
local maximized = {}

---Helper: Toggles maximization of current window
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
