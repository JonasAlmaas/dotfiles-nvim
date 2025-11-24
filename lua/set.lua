vim.opt.nu = true; -- Show current line number
vim.opt.relativenumber = true;

vim.opt.smartindent = true;

vim.opt.wrap = false;

--vim.opt.hlsearch = false;
--vim.opt.incsearch = true;

vim.opt.swapfile = false;
vim.opt.backup = false;
vim.opt.undodir = vim.fn.expand('$HOME/.vim/undodir');
vim.opt.undofile = true;

vim.opt.scrolloff = 8; -- Always keep 8 lines of margin around cursor
vim.opt.signcolumn = 'yes'; -- Always show signal column (Prevent flickering when entering and exiting insert mode)	

vim.opt.updatetime = 50;

vim.opt.colorcolumn = "80" -- Guideline

-- Render whitespace
vim.o.list = true
vim.o.listchars = 'tab:» ,lead:·,trail:·'

vim.diagnostic.config({
	virtual_text = {},
});
