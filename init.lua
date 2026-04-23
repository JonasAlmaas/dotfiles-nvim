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

vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = "#D02020" , bg = "#101010" })

