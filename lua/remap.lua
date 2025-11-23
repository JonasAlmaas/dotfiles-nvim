vim.g.mapleader = ' ';

vim.keymap.set('n', '<leader>pv', vim.cmd.Ex);

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
vim.keymap.set({'n', 'v'}, '<leader>y', [["+y]]);
vim.keymap.set('n', '<leader>Y', [["+Y]]);

-- Delete to void register
vim.keymap.set({'n', 'v'}, '<leader>d', [["_d]]);

-- Unbind Ex mode switch
vim.keymap.set('n', 'Q', '<nop>');

-- Replace hovered word
vim.keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]);

-- Useful keymap for editing configs
--vim.keymap.set('n', '<leader><leader>', function() vim.cmd([[so]]); end);

-- Only remap if an LSP is present
vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(e)
		local opts = {buffer = e.buf};
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts);
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts);
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts);
		vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts);
		vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts);
		vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts);
		vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts);
		vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts);
		vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts);
		vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts);
		vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts);
	end
});
