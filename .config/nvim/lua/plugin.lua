vim.pack.add {
	'https://github.com/folke/tokyonight.nvim',
	'https://github.com/neovim/nvim-lspconfig',
	'https://github.com/nvim-lua/plenary.nvim',
	'https://github.com/nvim-telescope/telescope.nvim',
}

--- Telescope

local telescope = require('telescope')
telescope.setup({})

local builtin = require('telescope.builtin')
local function telescope_search()
	vim.cmd('noau normal! "vy')
	local text = vim.fn.getreg('v')
	 builtin.live_grep({ default_text = text })
end

vim.keymap.set('n', '<leader>f', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>s', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('v', '<leader>s', telescope_search, { desc = 'Telescope live grep  selection' })

---

vim.cmd.colorscheme 'tokyonight'

vim.api.nvim_create_user_command('PackUpdate', function()
	vim.pack.update()
end, {})
