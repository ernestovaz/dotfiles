return {
  {
    -- obsidian vault integration
    "obsidian-nvim/obsidian.nvim",
    -- only load if vault directory exists
    cond = function()
      return vim.fn.isdirectory(vim.fn.expand("~/vault")) == 1
    end,
    opts = {
      lazy = true,
      workspaces = {
        {
          name = "vault",
          path = "~/vault",
        },
      },
      disable_frontmatter = true,
      ui = { enable = false },
    },
  },

  -- floating terminal window (:FloatermToggle)
  { "voldikss/vim-floaterm" },

  -- live markdown preview in browser (:LivedownToggle)
  { "shime/vim-livedown" },
}
