return {
  -- git commands via :G (e.g. :G blame, :G diff, :G log)
  'tpope/vim-fugitive',

  -- github integration for fugitive (:GBrowse)
  'tpope/vim-rhubarb',

  {
    -- gutter signs for added/changed/removed lines
    'lewis6991/gitsigns.nvim',
    opts = {
      on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk,
          { buffer = bufnr, desc = 'go to previous hunk' })
        vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk,
          { buffer = bufnr, desc = 'go to next hunk' })
        vim.keymap.set('n', 'gp', require('gitsigns').preview_hunk,
          { buffer = bufnr, desc = 'preview hunk changes' })
        vim.keymap.set('n', '<leader>gu', require('gitsigns').reset_hunk,
          { buffer = bufnr, desc = 'undo (reset) hunk' })
        vim.keymap.set('n', '<leader>gd', require('gitsigns').diffthis,
          { buffer = bufnr, desc = 'diff this buffer' })
      end,
    },
  },

  {
    -- github integration (issues, PRs, notifications)
    -- set OCTO_NVIM_URL and GH_ENTERPRISE_HOST env vars for enterprise github;
    -- falls back to upstream octo.nvim and default github.com when unset
    "octo.nvim",
    cmd = "Octo",
    url = os.getenv("OCTO_NVIM_URL") or "https://github.com/pwntester/octo.nvim.git",
    opts = {
      picker = "telescope",
      enable_builtin = true,
      github_hostname = os.getenv("GH_ENTERPRISE_HOST") or nil,
    },
    keys = {
      { "<leader>oi", "<CMD>Octo issue list<CR>", desc = "list github issues" },
      { "<leader>op", "<CMD>Octo pr list<CR>", desc = "list github pull requests" },
      { "<leader>od", "<CMD>Octo discussion list<CR>", desc = "list github discussions" },
      { "<leader>on", "<CMD>Octo notification list<CR>", desc = "list github notifications" },
      {
        "<leader>os",
        function()
          require("octo.utils").create_base_search_command { include_current_repo = true }
        end,
        desc = "search github",
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
  },
}
