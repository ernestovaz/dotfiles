return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    build = function()
      require("nvim-treesitter").install({
        "c", "cpp", "go", "lua", "python", "rust", "tsx", "typescript", "vimdoc", "vim", "elixir",
      })
    end,
    config = function()
      -- treesitter highlight and indent are now native in neovim 0.11+
      vim.treesitter.start = vim.treesitter.start or function() end

      -- textobjects config
      require("nvim-treesitter-textobjects").setup {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]m"] = "@class.outer",
            ["]]"] = "@function.outer",
          },
          goto_next_end = {
            ["]M"] = "@class.outer",
            ["]["] = "@function.outer",
          },
          goto_previous_start = {
            ["[m"] = "@class.outer",
            ["[["] = "@function.outer",
          },
          goto_previous_end = {
            ["[M"] = "@class.outer",
            ["[]"] = "@function.outer",
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>a"] = "@parameter.inner",
          },
          swap_previous = {
            ["<leader>A"] = "@parameter.inner",
          },
        },
      }

      -- incremental selection
      vim.keymap.set("n", "<C-space>", function()
        require("nvim-treesitter.incremental_selection").init_selection()
      end, { desc = "treesitter: init selection" })
      vim.keymap.set("x", "<C-space>", function()
        require("nvim-treesitter.incremental_selection").node_incremental()
      end, { desc = "treesitter: grow selection" })
      vim.keymap.set("x", "<M-space>", function()
        require("nvim-treesitter.incremental_selection").node_decremental()
      end, { desc = "treesitter: shrink selection" })
    end,
  },
}
