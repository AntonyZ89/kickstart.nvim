-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  "kdheepak/lazygit.nvim",
  "aserowy/tmux.nvim",
  "Exafunction/codeium.vim",
  "jiangmiao/auto-pairs",
  "mg979/vim-visual-multi",
  { "akinsho/toggleterm.nvim", config = true },
  {
    "antonyz89/electron-vue.nvim",
    dependencies = { "rktjmp/lush.nvim" },
    config = function()
      vim.cmd.colorscheme 'electron-vue-darker'
    end,
  },
  {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" }
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      keywords = {
        IMPORTANT = { icon = "! ", color = "#f44336" },
        QUESTION = { icon = "? ", color = "#9ACD32" }
      }
    },
  },
  {
    "tpope/vim-surround",
    dependencies = { "tpope/vim-repeat" },
  },
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    init = function() vim.g.mkdp_filetypes = { "markdown" } end,
    ft = { "markdown" },
  },
  {
    "NvChad/nvim-colorizer.lua",
    opts = {
      user_default_options = {
        names = true,
        tailwind = true,
      },
    },
  },
}
