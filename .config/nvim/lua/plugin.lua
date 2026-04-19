vim.pack.add {
	'https://github.com/folke/tokyonight.nvim',
	'https://github.com/neovim/nvim-lspconfig'
}

vim.cmd.colorscheme 'tokyonight'

vim.api.nvim_create_user_command('PackUpdate', function()
	vim.pack.update()
end, {})
