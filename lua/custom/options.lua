-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Enables pseudo-transparency for the |popup-menu|
vim.opt.pumblend = 10

vim.opt.guicursor = ""

-- Set highlight on search
vim.opt.hlsearch = false

-- Make line numbers default
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse mode
vim.opt.mouse = 'a'

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 50
vim.opt.timeoutlen = 300

-- Disable line wrapping
vim.opt.wrap = false

-- Set completeopt to have a better completion experience
vim.opt.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.opt.termguicolors = true

-- Neovide

vim.g.neovide_underline_stroke_scale = 2.0 -- fix underline thickness
vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_cursor_antialiasing = true
vim.g.neovide_transparency = 0.9
vim.g.neovide_refresh_rate = 60

-- transparency

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

-- netrw

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
