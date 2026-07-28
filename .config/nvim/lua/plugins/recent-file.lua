-- recent file quick-switcher
return {
  "ernestovaz/recent-file.nvim",
  dependencies = { "folke/which-key.nvim" },
  event = "VeryLazy",
  opts = {
    max_files = 9,
    trigger = "<Tab>",
  },
}
