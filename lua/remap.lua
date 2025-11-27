vim.g.mapleader = ' ';

--vim.keymap.set('n', '<leader>pv', vim.cmd.Ex);
vim.keymap.set('n', '<leader>e', function() vim.cmd(':Oil'); end);

-- Easy window navigation
vim.keymap.set('n', '<C-h>', '<C-w><C-h>');
vim.keymap.set('n', '<C-j>', '<C-w><C-j>');
vim.keymap.set('n', '<C-k>', '<C-w><C-k>');
vim.keymap.set('n', '<C-l>', '<C-w><C-l>');

-- Allow moving blocks of code in visual mode
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv");
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv");

-- Keep cursor centered when half page jumping
vim.keymap.set('n', '<C-d>', '<C-d>zz');
vim.keymap.set('n', '<C-u>', '<C-u>zz');
-- Keep cursor centered when jumping to next search result
vim.keymap.set('n', 'n', 'nzzzv');
vim.keymap.set('n', 'N', 'Nzzzv');

-- Paste without overwriting the buffer
vim.keymap.set('x', '<leader>p', [["_dP]]);

-- Yank to system clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]]);
vim.keymap.set('n', '<leader>Y', [["+Y]]);

-- Toggle hlsearch if it's on, otherwise just do "enter"
vim.keymap.set("n", "<CR>", function()
	---@diagnostic disable-next-line: undefined-field
	if vim.v.hlsearch == 1 then
		vim.cmd.nohl();
		return '';
	else
		return vim.keycode('<CR>');
	end
end, { expr = true })

-- Delete to void register
vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]]);

-- Unbind Ex mode switch
vim.keymap.set('n', 'Q', '<nop>');

-- Replace hovered word
--vim.keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]);

-- Useful keymap for editing configs
--vim.keymap.set('n', '<leader><leader>', function() vim.cmd([[so]]); end);

-- Only remap if an LSP is present
vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(e)
		local opts = { buffer = e.buf };
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts);
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts);
		vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts);
		vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts);
		vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts);
		vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts);
		vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts);
		vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts);
		vim.keymap.set('n', '<leader>o', function() vim.cmd(':LspClangdSwitchSourceHeader'); end);
		--vim.keymap.set("n", "<leader>fd", vim.lsp.buf.format, opts); -- Set in conform config

		-- This is default
		--vim.keymap.set("n", "[d", vim.lsp.diagnostic.goto_next, opts);
		--vim.keymap.set("n", "]d", vim.lsp.diagnostic.goto_prev, opts);
	end
});
