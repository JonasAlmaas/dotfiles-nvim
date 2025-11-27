require('set');
require('remap');
require('lazy_init');

require('floaterm');

-- Theme
--vim.cmd('colorscheme rose-pine');
--vim.cmd('colorscheme gruvbox');
--vim.cmd('colorscheme kanagawa-dragon');
vim.cmd.colorscheme("oasis");

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
	group = vim.api.nvim_create_augroup('HighlightYank', {}),
	pattern = '*',
	callback = function()
		vim.highlight.on_yank();
	end,
});
