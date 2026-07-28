return {
  -- {
  --   'github/copilot.vim',
  --   init = function()
  --     -- disable copilot's default Tab mapping so it doesn't conflict with
  --     -- nvim-cmp; use Shift-Tab to accept copilot suggestions instead
  --     vim.g.copilot_no_tab_map = true
  --     vim.keymap.set('i', '<S-Tab>', 'copilot#Accept("\\<CR>")', {
  --       expr = true,
  --       replace_keycodes = false,
  --     })
  --   end,
  -- },
  --
  -- {
  --   "CopilotC-Nvim/CopilotChat.nvim",
  --   build = "make tiktoken",
  --   opts = {
  --     model = "gpt-4o",
  --   },
  --   dependencies = {
  --     { "github/copilot.vim" },
  --     { "nvim-lua/plenary.nvim", branch = "master" },
  --   },
  -- },
  { "pablopunk/pi.nvim" }
}
