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
vim.keymap.set('n', '<leader><leader>', function() vim.cmd([[so]]); end);
