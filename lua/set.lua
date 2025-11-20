vim.opt.nu = true; -- Show current line number
vim.opt.relativenumber = true;

vim.opt.smartindent = true;

vim.opt.wrap = false;

vim.opt.hlsearch = false;
vim.opt.incsearch = true;

vim.opt.scrolloff = 8; -- Always keep 8 lines of margin around cursor

vim.opt.updatetime = 50;

vim.opt.colorcolumn = "80"

-- Render whitespace
vim.o.list = true
vim.o.listchars = 'tab:» ,lead:·,trail:·'
-- Trailing whitespace gets highlihghted red
vim.api.nvim_set_hl(0, 'TrailingWhitespace', {bg='LightRed'});
vim.api.nvim_create_autocmd('BufEnter', {
	pattern = '*',
	command = [[
		syntax clear TrailingWhitespace |
		syntax match TrailingWhitespace "\_s\+$"
	]]}
);

-- Always show signal column (Prevent flickering when entering and exiting insert mode)
vim.o.signcolumn = 'yes';
