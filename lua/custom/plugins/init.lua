-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  "kdheepak/lazygit.nvim",
  "aserowy/tmux.nvim",
  "Exafunction/codeium.vim",
  "jiangmiao/auto-pairs",
  {
    dir = "/var/www/nvim/electron-vue.nvim",
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
  -- { 'akinsho/toggleterm.nvim' }
}
