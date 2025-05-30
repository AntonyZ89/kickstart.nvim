-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
  --       These are some example plugins that I've included in the kickstart repository.
  --       Uncomment any of the lines below to enable them.
  require 'kickstart.plugins.autoformat',

  require 'kickstart.plugins.debug',
  -- NOTE: First, some plugins that don't require any configuration
  {
    "supermaven-inc/supermaven-nvim",
    config = function()
      require("supermaven-nvim").setup({
        log_level = "off",
      })
    end,
  },
  "mg979/vim-visual-multi",
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',
  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim',    opts = {} },
  { "akinsho/toggleterm.nvim", config = true },
  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim',   opts = {} },
  { "windwp/nvim-ts-autotag",  opts = {} },
  { "wakatime/vim-wakatime",   lazy = false },
  {
    "antonyz89/electron-vue.nvim",
    dependencies = { "rktjmp/lush.nvim" },
    config = function()
      vim.cmd.colorscheme 'electron-vue-darker'
    end,
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
    dependencies = { "tpope/vim-repeat" }
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
        tailwind = true,
      },
    },
  },
  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        theme = 'auto',
        component_separators = '|',
        section_separators = '',
      },
    },
  },
  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    main = "ibl",
    opts = {
      indent = { char = '┊' },
      scope = { enabled = false }
    },
  },
  {
    'altermo/ultimate-autopair.nvim',
    event = { 'InsertEnter', 'CmdlineEnter' },
    branch = 'v0.6',
    opts = {},
  },
  {
    "tzachar/highlight-undo.nvim",
    opts = {
      duration = 300,
      undo = {
        hlgroup = 'HighlightUndo',
        mode = 'n',
        lhs = 'u',
        map = 'undo',
        opts = {}
      },
      redo = {
        hlgroup = 'HighlightRedo',
        mode = 'n',
        lhs = '<C-r>',
        map = 'redo',
        opts = {}
      },
      highlight_for_count = true,
    }
  },
}
