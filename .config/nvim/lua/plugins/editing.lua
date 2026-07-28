return {
  -- detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- surround text objects with cs, ds, ys motions
  { 'tpope/vim-surround' },

  -- s/S motion for 2-character search (like f but two chars)
  { 'justinmk/vim-sneak' },

  -- highlight unique characters on f/F/t/T for quick jumping;
  -- priority 500 ensures highlight groups are set before colorscheme loads
  {
    'unblevable/quick-scope',
    priority = 500,
    init = function()
      vim.g.qs_highlight_on_keys = { 'f', 'F', 't', 'T', 's', 'S' }
      vim.api.nvim_set_hl(0, 'QuickScopePrimary', { fg = '#afff5f', underline = true })
      vim.api.nvim_set_hl(0, 'QuickScopeSecondary', { fg = '#5fffff', underline = true })
    end,
  },

  -- remember cursor position when reopening files
  { 'vladdoster/remember.nvim', opts = {} },
}
