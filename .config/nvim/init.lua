require('config.options')

-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)
require('lazy').setup({
  spec = {
    { import = "plugins" }
  },
  change_detection = {
    enabled = true,
    notify = false,
  },
})
require('config.keybinds')
require('config.autocmds')
require('pi').setup()

-- vim: ts=2 sts=2 sw=2 et
