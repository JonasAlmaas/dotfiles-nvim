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
		vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts);
		vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts);
		vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts);
		vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts);
		vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts);
		vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts);
		vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts);
		vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts);
		vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts);
		vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts);
	end
});
