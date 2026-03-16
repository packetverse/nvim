local opt = vim.opt

-- leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- share system clipboard
opt.clipboard = "unnamedplus"

-- line numbers
opt.number = true
opt.relativenumber = true

-- mouse support
opt.mouse = "a"

-- indentation
opt.expandtab = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4

opt.autoindent = true
opt.smartindent = true
opt.smarttab = true

-- backspace
opt.backspace = "indent,eol,start"

-- splits
opt.splitright = true
opt.splitbelow = true

-- 24-bit color support
opt.termguicolors = true

-- whitespace visualization
opt.list = true
opt.listchars = { tab = "»·", trail = "·", nbsp = "␣" }

-- misc
opt.wrap = false
opt.signcolumn = "yes"
opt.showmode = false
opt.undofile = true
opt.cursorline = true
opt.updatetime = 200
opt.ruler = false
opt.cmdheight = 1

-- search
opt.ignorecase = true
opt.smartcase = true
opt.scrolloff = 5
