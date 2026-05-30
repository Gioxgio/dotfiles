vim.pack.add {
	'https://github.com/folke/tokyonight.nvim',
	'https://github.com/neovim/nvim-lspconfig',
	'https://github.com/nvim-lua/plenary.nvim',
	'https://github.com/nvim-telescope/telescope.nvim',
	'https://github.com/lewis6991/gitsigns.nvim'
}

--- Telescope

local telescope = require('telescope')
telescope.setup({})

local builtin = require('telescope.builtin')
local function telescope_search_file()
	vim.cmd('noau normal! "vy')
	local text = vim.fn.getreg('v'):gsub("\n", "")
	builtin.find_files({ default_text = text })
end
local function telescope_search_text()
	vim.cmd('noau normal! "vy')
	local text = vim.fn.getreg('v'):gsub("\n", "\\n")
	builtin.live_grep({
		additional_args = function() return { "--multiline" } end,
		default_text = text
	})
end

vim.keymap.set('n', '<leader>o', builtin.find_files)
vim.keymap.set('v', '<leader>o', telescope_search_file)
vim.keymap.set('n', '<leader>F', builtin.live_grep)
vim.keymap.set('v', '<leader>F', telescope_search_text)

---

--- Gitsigns

local gitsigns = require('gitsigns')
gitsigns.setup({})

vim.keymap.set('n', ']c', function()
	if vim.wo.diff then
		vim.cmd.normal({ ']c', bang = true })
	else
		gitsigns.nav_hunk('next')
	end
end)

vim.keymap.set('n', '[c', function()
	if vim.wo.diff then
		vim.cmd.normal({ '[c', bang = true })
	else
		gitsigns.nav_hunk('prev')
	end
end)

vim.keymap.set('n', '<leader>hs', function() gitsigns.stage_hunk() end)
vim.keymap.set('v', '<leader>hs', function() gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end)
vim.keymap.set('n', '<leader>hS', function() gitsigns.stage_buffer() end)
vim.keymap.set('n', '<leader>hr', function() gitsigns.reset_hunk() end)
vim.keymap.set('v', '<leader>hr', function() gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end)
vim.keymap.set('n', '<leader>hR', function() gitsigns.reset_buffer() end)
vim.keymap.set('n', '<leader>hp', function() gitsigns.preview_hunk() end)
vim.keymap.set('n', '<leader>hd', function() gitsigns.diffthis('~') end)
vim.keymap.set('n', '<leader>hq', function() gitsigns.setqflist('all') end)
vim.keymap.set({ 'o', 'x' }, 'ih', function() gitsigns.select_hunk() end)

---

vim.cmd.colorscheme 'tokyonight'

vim.api.nvim_create_user_command('PackUpdate', function()
	vim.pack.update()
end, {})
