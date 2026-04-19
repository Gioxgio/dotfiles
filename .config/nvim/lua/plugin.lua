vim.pack.add{
	'https://github.com/neovim/nvim-lspconfig'
}

vim.api.nvim_create_user_command('PackUpdate', function()
  vim.pack.update()
end, {})
