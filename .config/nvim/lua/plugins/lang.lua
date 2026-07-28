return {
  {
    "elixir-tools/elixir-tools.nvim",
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local elixir = require("elixir")
      local elixirls = require("elixir.elixirls")

      -- note: hardcoded path to mason-installed elixir-ls binary;
      -- update this if your mason install location differs
      vim.lsp.config('elixirls', {
        cmd = { "/Users/I587281/.local/share/nvim/mason/bin/elixir-ls" },
      })
      vim.lsp.enable('elixirls')

      elixir.setup {
        nextls = { enable = true },
        elixirls = {
          enable = true,
          settings = elixirls.settings {
            dialyzerEnabled = false,
            enableTestLenses = false,
          },
          on_attach = function(_, bufnr)
            vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
            vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
            vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
          end,
        },
        projectionist = {
          enable = true,
        },
      }
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },

  -- syntax highlighting for haskell
  { 'neovimhaskell/haskell-vim' },

  -- syntax highlighting for helm templates
  { 'towolf/vim-helm' },
}
