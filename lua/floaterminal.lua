local state = {
	buf = -1,
	win = -1,
};

local create_floating_window = function(opts)
	opts = opts or {};

	local width = opts.width or math.floor(vim.o.columns * 0.8);
	local height = opts.height or math.floor(vim.o.lines * 0.8);

	local col = math.floor((vim.o.columns - width) / 2);
	local row = math.floor((vim.o.lines - height) / 2);

	local buf = nil;
	if vim.api.nvim_buf_is_valid(opts.buf) then
		buf = opts.buf;
	else
		buf = vim.api.nvim_create_buf(false, true); -- No file, scratch buffer
	end

	local win_conf = {
		relative = 'editor',
		width = width,
		height = height,
		col = col,
		row = row,
		style = 'minimal',
		border = 'rounded',
	};

	local win = vim.api.nvim_open_win(buf, true, win_conf);

	return {buf=buf, win=win};
end

local toggle_terminal = function()
	if not vim.api.nvim_win_is_valid(state.win) then
		state = create_floating_window({buf = state.buf});
		if vim.bo[state.buf].buftype ~= 'terminal' then
			vim.cmd.terminal();
		end
		vim.cmd('normal! i') -- Enter Terminal Job mode
	else
		vim.api.nvim_win_hide(state.win);
	end
end

vim.api.nvim_create_user_command('Floaterminal', toggle_terminal, {});

vim.keymap.set({'n', 't'}, '<leader>tt', toggle_terminal);
