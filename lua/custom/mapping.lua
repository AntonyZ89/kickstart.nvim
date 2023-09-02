local nmap = function(key, effect, desc)
  vim.keymap.set('n', key, effect, { silent = true, noremap = true, desc = desc })
end

local vmap = function(key, effect, desc)
  vim.keymap.set('v', key, effect, { silent = true, noremap = true, desc = desc })
end

local imap = function(key, effect, desc)
  vim.keymap.set('i', key, effect, { silent = true, noremap = true, desc = desc })
end

-- TODO: create tmap for terminal mapping

--  General
nmap('<c-s>', '<cmd>:w<cr>', 'Save file')
imap('<c-s>', '<cmd>:w<cr><esc>', 'Save file and back to normal mode')

nmap('<c-j>', '<c-w>j', 'Move to top window')
nmap('<c-k>', '<c-w>k', 'Move to bottom window')
nmap('<c-h>', '<c-w>h', 'Move to left window')
nmap('<c-l>', '<c-w>l', 'Move to right window')

-- LazyGit
nmap('<leader>gg', ':LazyGit<cr>', 'Open LazyGit')

-- Harpoon
local mark = require('harpoon.mark')
local ui = require('harpoon.ui')

nmap('<leader>a', mark.add_file, '[Harpoon] Add file')
nmap('<C-e>', ui.toggle_quick_menu, '[Harpoon] Toggle menu')

nmap('L', ui.nav_next, '[Harpoon] Next')
nmap('H', ui.nav_prev, '[Harpoon] Prev')

-- Terminal
-- TODO: mappings
--
local opts = { buffer = 0 }
vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)

vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
-- vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
