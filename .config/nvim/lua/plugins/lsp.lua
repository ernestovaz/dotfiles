return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
      -- lsp progress indicator in the bottom right
      { "j-hui/fidget.nvim", opts = {} },
      -- better lua_ls integration for neovim config/api
      { "folke/lazydev.nvim", ft = "lua", opts = {} },
    },
    config = function()
      -- on_attach: keymaps that only activate when an LSP is connected
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = function(event)
          local bufnr = event.buf
          local nmap = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
          end

          -- refactoring
          nmap("<leader>rn", vim.lsp.buf.rename, "rename")
          nmap("<leader>ca", vim.lsp.buf.code_action, "code action")

          -- navigation
          nmap("gd", vim.lsp.buf.definition, "goto definition")
          nmap("gr", require("telescope.builtin").lsp_references, "goto references")
          nmap("gI", vim.lsp.buf.implementation, "goto implementation")
          nmap("gD", vim.lsp.buf.declaration, "goto declaration")
          nmap("<leader>D", vim.lsp.buf.type_definition, "type definition")

          -- symbols
          nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "document symbols")
          nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "workspace symbols")

          -- documentation
          nmap("K", vim.lsp.buf.hover, "hover documentation")
          nmap("gK", vim.lsp.buf.signature_help, "signature documentation")

          -- workspace management
          nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "workspace add folder")
          nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "workspace remove folder")
          nmap("<leader>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, "workspace list folders")

          -- buffer-local :Format command
          vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
            vim.lsp.buf.format()
          end, { desc = "format current buffer with LSP" })
        end,
      })

      -- capabilities for cmp
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      -- configure servers via vim.lsp.config (neovim 0.11+ native API)
      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        settings = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      })

      -- mason-lspconfig: auto-install and auto-enable
      require("mason-lspconfig").setup {
        ensure_installed = { "lua_ls" },
        automatic_enable = true,
      }
    end,
  },
}
