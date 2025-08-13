vim.lsp.enable('c_ls')
vim.lsp.enable('json_ls')
vim.lsp.enable('lua_ls')

vim.lsp.config('lua_ls', {
	settings = {
		Lua = {
			workspace = {
				library = vim.api.nvim_get_runtime_file('', true) }
		}
	}
})

-- Ctrl-Space	Autocomplete
-- gd		Definition
-- gf		Format

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(args)
		local buffer = args.buf
		local client_id = args.data.client_id

		local client = vim.lsp.get_client_by_id(client_id)

		if not client then return end

		-- shortcut
		local opts = { buffer = buffer }
		vim.keymap.set('i', '<c-space>', '<c-x><c-o>', opts)
		vim.keymap.set({ 'n', 'x' }, 'gf', '<cmd>lua vim.lsp.buf.format({async = true })<cr>', opts)

		-- auto-completion
		if client:supports_method('textDocument/completion') then
			vim.cmd [[set completeopt+=menuone,fuzzy,noinsert,popup]]
			vim.lsp.completion.enable(true, client_id, buffer, { autotrigger = true })
		end

		-- inlay diagnostic
		if client:supports_method('textDocument/publishDiagnostics') then
			vim.diagnostic.config({ virtual_text = true, signs = true, })
		end

		-- inlay hints
		if client:supports_method('textDocument/inlayHint') then
			vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
		end

		-- document highlit
		-- when cursor is idle shows other references of the symbol under the cursor
		if client:supports_method('textDocument/documentHighlight') then
			local autocmd = vim.api.nvim_create_autocmd
			local augroup = vim.api.nvim_create_augroup('lsp_highlight', { clear = false })

			vim.api.nvim_clear_autocmds({ buffer = buffer, group = augroup })

			autocmd({ 'cursorhold' }, {
				group = augroup,
				buffer = args.buf,
				callback = vim.lsp.buf.document_highlight,
			})

			autocmd({ 'cursormoved' }, {
				group = augroup,
				buffer = args.buf,
				callback = vim.lsp.buf.clear_references,
			})
		end

		-- Tab to navigate/autocomplete
		vim.opt.shortmess:append('c')
		local function tab_complete()
			if vim.fn.pumvisible() == 1 then
				-- navigate to next item in completion menu
				return '<Down>'
			end

			local c = vim.fn.col('.') - 1
			local is_whitespace = c == 0 or vim.fn.getline('.'):sub(c, c):match('%s')

			if is_whitespace then
				-- insert tab
				return '<Tab>'
			end

			local lsp_completion = vim.bo.omnifunc == 'v:lua.vim.lsp.omnifunc'

			if lsp_completion then
				-- trigger lsp code completion
				return '<C-x><C-o>'
			end

			-- suggest words in current buffer
			return '<C-x><C-n>'
		end

		local function tab_prev()
			if vim.fn.pumvisible() == 1 then
				-- navigate to previous item in completion menu
				return '<Up>'
			end

			-- insert tab
			return '<Tab>'
		end

		vim.keymap.set('i', '<Tab>', tab_complete, { expr = true })
		vim.keymap.set('i', '<S-Tab>', tab_prev, { expr = true })
	end,
})
