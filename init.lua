require('set');
require('remap');
require('lazy_init');

require('floaterm');

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
	group = vim.api.nvim_create_augroup('HighlightYank', {}),
	pattern = '*',
	callback = function()
		vim.highlight.on_yank();
	end,
});
