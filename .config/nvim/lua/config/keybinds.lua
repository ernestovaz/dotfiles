-- disable space in normal/visual so it only acts as leader
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- motion: j/k navigate by visual line when no count is given (for word-wrap)
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- clipboard: "" prefix switches to the system clipboard register (+)
-- so ""y yanks to system clipboard, ""p pastes from it, etc.
vim.keymap.set('n', '""', '"+')
vim.keymap.set('v', '""', '"+')

-- clipboard: \ copies the unnamed register (") into the system clipboard (+)
vim.keymap.set('n', '\\', ':let @+=@"<CR>', { silent = true })
vim.keymap.set('v', '\\', ':let @+=@"<CR>', { silent = true })

-- clipboard: <leader>y/Y yank to system clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- clipboard: <leader>p/P paste from system clipboard
vim.keymap.set("n", "<leader>p", "\"+p")
vim.keymap.set("v", "<leader>p", "\"+p")
vim.keymap.set("n", "<leader>P", "\"+P")

-- delete to void register (don't clobber clipboard)
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

-- move selected lines up/down in visual mode, reindent and reselect
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

-- keep cursor centered while scrolling half-pages
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- stay in visual mode after indent so you can keep adjusting
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

-- use backspace to alternate between last file and current file
vim.keymap.set("n", "<BS>", "<C-^>")

-- open netrw file explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- diagnostics
vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = 'go to previous diagnostic message' })
vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1, float = true }) end, { desc = 'go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'open diagnostics list' })

-- save with ctrl-s in any mode
vim.keymap.set("n", "<C-s>", ":w<CR>")
vim.keymap.set("v", "<C-s>", ":w<CR>")
vim.keymap.set("i", "<C-s>", "<C-o>:w<CR>")
