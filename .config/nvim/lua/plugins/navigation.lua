return {
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      defaults = {
        path_display = {
          filename_first = {
            reverse_directories = true,
          },
        },
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
        file_ignore_patterns = { "^vendor/", "^.idea" },
        mappings = {
          i = {
            -- disable these so C-u/C-d don't clear the prompt or scroll
            -- the preview; lets them fall through to normal behavior
            ['<C-u>'] = false,
            ['<C-d>'] = false,
          },
        },
      },
    },
    config = function(_, opts)
      require('telescope').setup(opts)

      -- load fzf-native extension for better sorting (fails silently if not installed)
      pcall(require('telescope').load_extension, 'fzf')

      -- keymaps
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = 'find recently opened files' })
      vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = 'find existing buffers' })
      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = 'fuzzily search in current buffer' })

      vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = 'search git files' })
      vim.keymap.set('n', '<leader>sf', function()
        builtin.find_files({ no_ignore = true, no_ignore_parent = true, hidden = true })
      end, { desc = 'search files' })
      vim.keymap.set('n', '<leader>sr', builtin.oldfiles, { desc = 'search recent' })
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'search help' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = 'search current word' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'search by grep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = 'search diagnostics' })
    end,
  },

  {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- compiled C extension for fzf-quality sorting in telescope
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },

  {
    'preservim/nerdtree',
    init = function()
      vim.g.NERDTreeWinPos = 'right'
      vim.keymap.set('n', '<leader>n', vim.cmd.NERDTreeToggle, { desc = 'toggle nerdtree' })
    end,
  },

  -- seamless navigation between tmux panes and vim splits
  { 'christoomey/vim-tmux-navigator' },
}
