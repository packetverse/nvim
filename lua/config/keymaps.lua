local core = require("core")
local shell_utils = require("core.shell")

-- Misc
core.keymap("n", "<leader>L", ":Lazy<CR>", "Open Lazy")

-- Writing and saving
core.keymap("n", "<leader>w", ":write<CR>", "Save current buffer")
-- core.keymap("n", "<leader>q", ":bdelete<CR>", "Quit current buffer")
-- core.keymap("n", "<leader>x", ":bdelete<CR>", "Quit current buffer")
-- core.keymap("n", "<leader>q", ":quit<CR>", "Quit current buffer")
core.keymap("n", "<leader>x", ":quit<CR>", "Quit")
-- core.keymap("n", "<leader>x", ":write | quit<CR>", "Save and quit")
core.keymap("n", "<leader>so", ":so %<CR>", "Source current file")

-- Window/split navigation
core.keymap("n", "<C-h>", "<C-w>h", "Navigate to left window")
core.keymap("n", "<C-j>", "<C-w>j", "Navigate to down window")
core.keymap("n", "<C-k>", "<C-w>k", "Navigate to up window")
core.keymap("n", "<C-l>", "<C-w>l", "Navigate to right window")

core.keymap("n", "<leader>sv", "<C-w>v", "Split vertically")
core.keymap("n", "<leader>sh", "<C-w>s", "Split horizontally")
core.keymap("n", "<leader>se", "<C-w>=", "Split horizontally")
core.keymap("n", "<leader>sx", ":close<CR>", "Close split")
core.keymap("n", "<leader>sm", function()
  core.toggle_maximize()
end, "Toggle maximize split")

-- Buffer navigation
core.keymap("n", "<leader>bn", ":bnext<CR>", "Next buffer")
core.keymap("n", "<leader>bp", ":bprevious<CR>", "Previous buffer")
core.keymap("n", "<leader>bd", ":bdelete<CR>", "Delete current buffer")

core.keymap_range("n", 1, 9, function(i)
  return "<M-" .. i .. ">"
end, core.go_to_buffer, "Go to buffer")

-- Tab navigation
core.keymap("n", "<leader>to", ":tabnew<CR>", "Open new tab")
core.keymap("n", "<leader>tx", ":tabclose<CR>", "Close current tab")
core.keymap("n", "tn", ":tabnext<CR>", "Navigate to next tab")
core.keymap("n", "tp", ":tabprevious<CR>", "Navigate to previous tab")

-- Move lines in visual mode
core.keymap("v", "J", ":m '>+1<CR>gv=gv", "Moves lines down in VISUAL selection")
core.keymap("v", "K", ":m '<-2<CR>gv=gv", "Moves lines up in VISUAL selection")

-- Clear search highlight
core.keymap("n", "<C-c>", ":nohl<CR>", "Clear search highlight")
core.keymap("n", "<Esc>", ":nohl<CR>", "Clear search highlight")

-- Exit terminal mode with ESC
core.keymap("t", "<Esc>", "<C-\\><C-n>", "Exit terminal mode")

-- Naviate splits within terminal with keybind
core.keymap("t", "<C-h>", "<C-\\><C-n><C-w><C-h>", "Navigate to left window")
core.keymap("t", "<C-j>", "<C-\\><C-n><C-w><C-j>", "Navigate to down window")
core.keymap("t", "<C-k>", "<C-\\><C-n><C-w><C-k>", "Navigate to up window")
core.keymap("t", "<C-l>", "<C-\\><C-n><C-w><C-l>", "Navigate to right window")

-- Properly move between highlighted search results
core.keymap("n", "n", "nzzzv")
core.keymap("n", "n", "nzzzv")

-- Center when scrolling down and upwards
core.keymap("n", "<C-d>", "<C-d>zz")
core.keymap("n", "<C-u>", "<C-u>zz")
core.keymap("n", "<C-f>", "<C-f>zz")
core.keymap("n", "<C-b>", "<C-b>zz")

-- Disable arrow keys in almost all modes
local modes = { "n", "i", "v", "o", "t", "s", "x" }
local arrows = { "<Up>", "<Down>", "<Left>", "<Right>" }

for _, mode in ipairs(modes) do
  for _, key in ipairs(arrows) do
    core.keymap(mode, key, "<Nop>")
  end
end

-- Map Alt + hjkl in insert mode to prevent switching between normal and insert frequently
local enabledModes = { "i", "c", "o", "t", "s", "x" }
local altKeys = { h = "<Left>", j = "<Down>", k = "<Up>", l = "<Right>" }
for _, mode in ipairs(enabledModes) do
  for key, mapping in pairs(altKeys) do
    core.keymap(mode, "<M-" .. key .. ">", mapping, "Alt + " .. key .. " in " .. mode .. " mode")
  end
end

-- Copy filepath to clipboard
core.keymap("n", "<leader>fp", function()
  local file_path = vim.fn.expand("%:~")
  vim.fn.setreg("+", file_path)
  print("file path copied to clipboard: " .. file_path)
end, "Copy file path to clipboard")

-- Custom shell picker
core.keymap("n", "<leader>us", function()
  shell_utils.select_shell()
end, "Select shell with custom picker")
