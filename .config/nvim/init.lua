local undo_dir = vim.fn.stdpath('data') .. '/undodir'
if vim.fn.isdirectory(undo_dir) == 0 then
	vim.fn.mkdir(undo_dir, 'p')
end

vim.g.mapleader = ' '

vim.o.mouse = ''
vim.o.winborder = 'rounded'
vim.o.updatetime = 1000
vim.o.wrap = false

vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = 'yes'

vim.o.shiftwidth = 4
vim.o.tabstop = 4

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.undofile = true
vim.o.undodir = undo_dir


vim.keymap.set({ 'i', 'n' }, '<up>', '<nop>', { silent = true })
vim.keymap.set({ 'i', 'n' }, '<down>', '<nop>', { silent = true })
vim.keymap.set({ 'i', 'n' }, '<left>', '<nop>', { silent = true })
vim.keymap.set({ 'i', 'n' }, '<right>', '<nop>', { silent = true })

vim.keymap.set('i', 'jk', '<esc>', { silent = true })
vim.keymap.set('t', 'jk', '<c-\\><c-n>', { silent = true })
vim.keymap.set('t', '<esc>', '<c-\\><c-n>', { silent = true })

vim.keymap.set({ 'n', 'v' }, '<leader>c', '"+y')
vim.keymap.set('n', '<leader>r', ':update<cr> :source<cr>')
vim.keymap.set('n', '<leader>w', ':write<cr>')

vim.keymap.set('n', '<leader>x', 'ma0ci[x<esc>`a') -- Useful to tick [ ]


require('lsp_config')
