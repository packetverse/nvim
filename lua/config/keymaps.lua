-- Misc
vim.keymap.set("n", "<leader>L", "<CMD>Lazy<CR>", { desc = "Open Lazy" })

-- Writing and saving
vim.keymap.set("n", "<leader>w", "<CMD>write<CR>", { desc = "Save current buffer" })
vim.keymap.set("n", "<leader>x", "<CMD>quit<CR>", { desc = "Quit" })
vim.keymap.set("n", "<leader>so", "<CMD>so %<CR>", { desc = "Source current file" })

-- Window/split navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Navigate to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Navigate to down window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Navigate to up window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Navigate to right window" })

vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split vertically" })
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split horizontally" })
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make split equal size" })
vim.keymap.set("n", "<leader>sx", "<CMD>close<CR>", { desc = "Close split" })
vim.keymap.set("n", "<leader>sm", function()
  require("core.utils").toggle_maximize()
end, { desc = "Toggle maximize split" })

-- Buffer navigation
vim.keymap.set("n", "<leader>bn", "<CMD>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", "<CMD>bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bd", "<CMD>bdelete<CR>", { desc = "Delete current buffer" })

for i = 1, 9 do
  vim.keymap.set("n", "<M-" .. i .. ">", function()
    require("core.utils").goto_buffer(i)
  end, { silent = true, desc = "Go to buffer " .. i })
end

-- Tab navigation
vim.keymap.set("n", "<leader>to", "<CMD>tabnew<CR>", { desc = "Open new tab" })
vim.keymap.set("n", "<leader>tx", "<CMD>tabclose<CR>", { desc = "Close current tab" })
vim.keymap.set("n", "tn", "<CMD>tabnext<CR>", { desc = "Navigate to next tab" })
vim.keymap.set("n", "tp", "<CMD>tabprevious<CR>", { desc = "Navigate to previous tab" })

-- Move lines in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true, desc = "Moves lines down in VISUAL selection" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true, desc = "Moves lines up in VISUAL selection" })

-- Clear search highlight
vim.keymap.set("n", "<C-c>", "<CMD>nohl<CR>", { desc = "Clear search highlight" })

-- Exit terminal mode with Esc
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Naviate splits within terminal with keybind
vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w><C-h>", { desc = "Navigate to left window" })
vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w><C-j>", { desc = "Navigate to down window" })
vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w><C-k>", { desc = "Navigate to up window" })
vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w><C-l>", { desc = "Navigate to right window" })

-- Properly move between highlighted search results
vim.keymap.set("n", "n", "nzzzv", { desc = "Move to next match and center cursor" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Move to previous match and center cursor" })

-- Center when scrolling down and upwards
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down half-page and center cursor" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up half-page and center cursor" })
vim.keymap.set("n", "<C-f>", "<C-f>zz", { desc = "Scroll down page and center cursor" })
vim.keymap.set("n", "<C-b>", "<C-b>zz", { desc = "Scroll up page and center cursor" })

-- Disable arrow keys in almost all modes
local arrow_modes = { "n", "i", "v", "o", "t", "s", "x" }
local arrow_keys = { "<Up>", "<Down>", "<Left>", "<Right>" }

for _, mode in ipairs(arrow_modes) do
  for _, key in ipairs(arrow_keys) do
    vim.keymap.set(mode, key, "<Nop>")
  end
end

-- Map Alt + hjkl in insert mode to prevent switching between normal and insert frequently
local alt_modes = { "i", "c", "o", "t", "s", "x" }
local alt_keys = { h = "<Left>", j = "<Down>", k = "<Up>", l = "<Right>" }
for _, mode in ipairs(alt_modes) do
  for key, mapping in pairs(alt_keys) do
    vim.keymap.set(mode, "<M-" .. key .. ">", mapping, { desc = "Alt + " .. key .. " in " .. mode .. " mode" })
  end
end

-- Copy filepath to clipboard
vim.keymap.set("n", "<leader>fp", function()
  local file_path = vim.fn.expand("%:~")
  vim.fn.setreg("+", file_path)
  print("file path copied to clipboard: " .. file_path)
end, { desc = "Copy file path to clipboard" })
