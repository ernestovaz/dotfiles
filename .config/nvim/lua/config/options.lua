-- leader key (must be set before lazy.nvim)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- indentation
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 0
vim.opt.shiftwidth = 2

-- disable persistent search highlighting
vim.o.hlsearch = false

-- show relative line numbers
vim.wo.relativenumber = true

-- enable mouse in all modes
vim.o.mouse = 'a'

-- sync clipboard between OS and neovim
--  remove this option if you want your OS clipboard to remain independent
--  see `:help 'clipboard'`
-- vim.o.clipboard = 'unnamedplus'

-- enable break indent
vim.o.breakindent = true

-- persist undo history to disk
vim.o.undofile = true

-- case-insensitive searching unless \C or a capital letter is in the pattern
vim.o.ignorecase = true
vim.o.smartcase = true

-- show signs in the number column instead of a separate sign column
vim.wo.signcolumn = 'number'

-- lower updatetime for faster CursorHold events (default 4000ms)
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 500

-- better completion experience: show menu even for one match, don't auto-select
vim.o.completeopt = 'menuone,noselect'

-- enable 24-bit RGB color in the TUI
vim.o.termguicolors = true

-- disable inline diagnostic virtual text (use floating windows instead)
vim.diagnostic.config({
  virtual_text = false,
})
