local nmap = function(key, effect, desc)
  vim.keymap.set('n', key, effect, { silent = true, noremap = true, desc = desc })
end

local vmap = function(key, effect, desc)
  vim.keymap.set('v', key, effect, { silent = true, noremap = true, desc = desc })
end

local imap = function(key, effect, desc)
  vim.keymap.set('i', key, effect, { silent = true, noremap = true, desc = desc })
end

local tmap = function(key, effect)
  vim.keymap.set('t', key, effect, { buffer = 0 })
end

--  General
nmap('<c-s>', '<cmd>:w<cr>', 'Save file')
imap('<c-s>', '<cmd>:w<cr><esc>', 'Save file and back to normal mode')
nmap('<leader>o', '<cmd>:Explore<cr>', 'Open Explorer')

nmap('<c-j>', '<c-w>j', 'Move to top window')
nmap('<c-k>', '<c-w>k', 'Move to bottom window')
nmap('<c-h>', '<c-w>h', 'Move to left window')
nmap('<c-l>', '<c-w>l', 'Move to right window')

nmap('<C-p>', '<C-d>zz', 'Redo and center cursor')
nmap('<C-u>', '<C-u>zz', 'Undo and center cursor')

imap('jk', '<esc>', 'Exit insert mode')

vmap('p', '"_dP', 'Paste without yanking')

vmap('J', ":m '>+1<CR>gv=gv", 'Move down')
vmap('K', ":m '<-2<CR>gv=gv", 'Move up')

-- LazyGit
nmap('<leader>gg', ':LazyGit<cr>', 'Open LazyGit')

-- Terminal
nmap("<leader>tf", "<cmd>ToggleTerm direction=float<cr>", "Open terminal on float")
nmap("<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Open terminal on horizontal split")
nmap("<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Open terminal on vertical split")

function _G.set_terminal_keymaps()
  tmap('<esc>', [[<C-\><C-n>]])

  tmap('<C-h>', [[<Cmd>wincmd h<CR>]])
  tmap('<C-j>', [[<Cmd>wincmd j<CR>]])
  tmap('<C-k>', [[<Cmd>wincmd k<CR>]])
  tmap('<C-l>', [[<Cmd>wincmd l<CR>]])
  tmap('<C-w>', [[<C-\><C-n><C-w>]])
end

-- register terminal keymaps
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
