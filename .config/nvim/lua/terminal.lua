vim.api.nvim_create_autocmd('TermOpen', {
	group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
	callback = function()
		vim.o.number = false
		vim.o.relativenumber = false
	end
})

local state = {
	floating = {
		buf = -1,
		win = -1,
	}
}

local function create_floating_window()
	local width = math.floor(vim.o.columns * 0.8)
	local height = math.floor(vim.o.lines * 0.8)
	local col = math.floor((vim.o.columns - width) / 2)
	local row = math.floor((vim.o.lines - height) / 2)

	if not vim.api.nvim_buf_is_valid(state.floating.buf) then
		state.floating.buf = vim.api.nvim_create_buf(false, true)
	end

	local win_config = {
		relative = 'editor',
		width = width,
		height = height,
		col = col,
		row = row,
		border = 'rounded',
	}

	state.floating.win = vim.api.nvim_open_win(state.floating.buf, true, win_config)
end

local toggle_terminal = function()
	if not vim.api.nvim_win_is_valid(state.floating.win) then
		create_floating_window()
	else
		vim.api.nvim_win_hide(state.floating.win)
	end

	if vim.bo[state.floating.buf].buftype ~= 'terminal' then
		vim.cmd('terminal')
	end

	vim.cmd('startinsert')
end

vim.keymap.set('t', 'jk', '<c-\\><c-n>', { silent = true })
vim.keymap.set('t', '<esc>', '<c-\\><c-n>', { silent = true })
vim.keymap.set({ 'n', 't' }, '<leader>t', toggle_terminal)
