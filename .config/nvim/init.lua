local undo_dir = vim.fn.stdpath('data') .. '/undodir'
if vim.fn.isdirectory(undo_dir) == 0 then
	vim.fn.mkdir(undo_dir, 'p')
end

vim.g.mapleader = ' '

vim.o.mouse = ''
vim.opt.belloff = 'all'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.winborder = 'rounded'

vim.o.number = true
vim.o.relativenumber = true
vim.o.scrolloff = 10
vim.o.signcolumn = 'yes'

vim.o.list = true
vim.opt.listchars = { tab = '  ', trail = '·', nbsp = '␣' }
vim.o.shiftwidth = 4
vim.o.tabstop = 4

vim.o.ignorecase = true
vim.o.inccommand = 'split'
vim.o.smartcase = true

vim.o.confirm = true
vim.o.undofile = true
vim.o.undodir = undo_dir

vim.o.foldenable = false
vim.o.foldlevel = 99
vim.o.foldmethod = 'indent'

vim.keymap.set({ 'i', 'n' }, '<up>', '<nop>', { silent = true })
vim.keymap.set({ 'i', 'n' }, '<down>', '<nop>', { silent = true })
vim.keymap.set({ 'i', 'n' }, '<left>', '<nop>', { silent = true })
vim.keymap.set({ 'i', 'n' }, '<right>', '<nop>', { silent = true })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { silent = true })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { silent = true })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { silent = true })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { silent = true })

vim.keymap.set('i', 'jk', '<esc>', { silent = true })

vim.keymap.set({ 'n', 'v' }, '<leader>c', '"+y', { silent = true })
vim.keymap.set('n', '<leader>r', ':update<cr> :source<cr>', { silent = true })
vim.keymap.set('n', '<leader>w', ':write<cr>', { silent = true })
vim.keymap.set('n', '<leader>x',
	'ma:s/\\v(\\[x]|\\[ ])/\\=submatch(1)==\'[x]\'?\'[ ]\':\'[x]\'/e<cr>:nohlsearch<esc>`a', { silent = true }) -- Useful to tick [ ]


require('terminal')
require('plugin')
require('lsp_config')
