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

vim.keymap.set('n', '<leader>o', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('v', '<leader>o', telescope_search_file, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>F', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('v', '<leader>F', telescope_search_text, { desc = 'Telescope live grep selection' })

---

vim.cmd.colorscheme 'tokyonight'

vim.api.nvim_create_user_command('PackUpdate', function()
	vim.pack.update()
end, {})
