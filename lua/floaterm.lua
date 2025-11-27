local state = {
	winid = -1,
	bufids = {},
	curr_bufix = -1,
};

local draw_tabline = function()
	local s = "%#StatusLineTermNC#"
	for i = 1, #state.bufids do
		if i == state.curr_bufix then
			s = s .. "%#StatusLineTerm# [" .. i .. "] %#StatusLineTermNC#"
		else
			s = s .. " " .. i .. " "
		end
	end

	s = s .. "%= <>th prev │ <>tl next | <>tc create | <>td delete | <>tda delete all";
	return s;
end

local create_floating_window = function(opts)
	opts = opts or {};

	local bufid = opts.bufid or 0;

	local width = opts.width or math.floor(vim.o.columns * 0.8);
	local height = opts.height or math.floor(vim.o.lines * 0.8);

	local col = math.floor((vim.o.columns - width) / 2);
	local row = math.floor((vim.o.lines - height) / 2);

	local win_conf = {
		relative = 'editor',
		width = width,
		height = height - 1, -- Leave 1 line for the tabline
		col = col,
		row = row + 1, -- +1 so the tabline can be on the top
		style = 'minimal',
		border = 'rounded',
	};

	local winid = vim.api.nvim_open_win(bufid, true, win_conf);

	vim.api.nvim_set_option_value('winbar', draw_tabline(), { win = winid });

	vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'NONE' });
	vim.wo[winid].winhighlight = 'Normal:Normal';

	return winid;
end

local open_terminal = function()
	if vim.api.nvim_win_is_valid(state.winid) then
		return;
	end

	if state.curr_bufix == -1 then
		state.curr_bufix = 1;
		state.bufids[state.curr_bufix] = vim.api.nvim_create_buf(false, true);
	end

	local bufid = state.bufids[state.curr_bufix];

	state.winid = create_floating_window({ bufid = bufid });

	if vim.bo[bufid].buftype ~= 'terminal' then
		vim.cmd.terminal();
	end
	vim.cmd('normal! i') -- Enter Terminal Job mode
end

local close_terminal = function()
	if vim.api.nvim_win_is_valid(state.winid) then
		vim.api.nvim_win_hide(state.winid);
	end
end

local toggle_terminal = function()
	if vim.api.nvim_win_is_valid(state.winid) then
		close_terminal();
	else
		open_terminal();
	end
end

local open_curr_buf = function()
	local bufid = state.bufids[state.curr_bufix];

	vim.api.nvim_win_set_buf(state.winid, bufid);
	vim.api.nvim_set_option_value('winbar', draw_tabline(), { win = state.winid });

	if vim.bo[bufid].buftype ~= 'terminal' then
		vim.cmd.terminal();
	end
end

local new_buf = function()
	if not vim.api.nvim_win_is_valid(state.winid) then
		return;
	end

	state.curr_bufix = #state.bufids + 1;
	state.bufids[state.curr_bufix] = vim.api.nvim_create_buf(false, true);

	open_curr_buf();
end

local delete_buf = function()
	if not vim.api.nvim_win_is_valid(state.winid) or state.curr_bufix == -1 then
		return;
	end

	local bufid = state.bufids[state.curr_bufix];

	table.remove(state.bufids, state.curr_bufix);
	state.curr_bufix = state.curr_bufix - 1;

	if state.curr_bufix < 1 then
		state.curr_bufix = 1;
		state.bufids[state.curr_bufix] = vim.api.nvim_create_buf(false, true);
	end

	open_curr_buf();

	vim.api.nvim_buf_delete(bufid, { force = true });
end

local delete_all_bufs = function()
	if not vim.api.nvim_win_is_valid(state.winid) or state.curr_bufix == -1 then
		return;
	end

	local old_bufids = state.bufids;

	state.bufids = {};
	state.curr_bufix = 1;
	state.bufids[state.curr_bufix] = vim.api.nvim_create_buf(false, true);

	open_curr_buf();

	for _, bufid in pairs(old_bufids) do
		vim.api.nvim_buf_delete(bufid, { force = true });
	end
end

local next_buf = function()
	if not vim.api.nvim_win_is_valid(state.winid) then
		return;
	end

	state.curr_bufix = state.curr_bufix + 1;
	if state.curr_bufix > #state.bufids then
		state.curr_bufix = 1;
	end

	open_curr_buf();
end

local prev_buf = function()
	if not vim.api.nvim_win_is_valid(state.winid) then
		return;
	end

	state.curr_bufix = state.curr_bufix - 1;
	if state.curr_bufix < 1 then
		state.curr_bufix = #state.bufids;
	end

	open_curr_buf();
end

local goto_buf = function(bufix)
	if bufix > #state.bufids then
		for i = #state.bufids + 1, bufix do
			state.bufids[i] = vim.api.nvim_create_buf(false, true);
		end
	end

	state.curr_bufix = bufix;

	if vim.api.nvim_win_is_valid(state.winid) then
		open_curr_buf();
	else
		open_terminal();
	end
end

vim.api.nvim_create_user_command('FloatermOpen', open_terminal, {});
vim.api.nvim_create_user_command('FloatermClose', close_terminal, {});
vim.api.nvim_create_user_command('FloatermToggle', toggle_terminal, {});
vim.api.nvim_create_user_command('FloatermNewbuf', new_buf, {});
vim.api.nvim_create_user_command('FloatermDeleteBuf', delete_buf, {});
vim.api.nvim_create_user_command('FloatermDeleteAllBufs', delete_all_bufs, {});
vim.api.nvim_create_user_command('FloatermNextBuf', next_buf, {});
vim.api.nvim_create_user_command('FloatermPrevBuf', prev_buf, {});

vim.keymap.set({ 'n', 't' }, '<leader>tt', toggle_terminal);
vim.keymap.set({ 't' }, '<esc>', close_terminal, {});
vim.keymap.set({ 't' }, '<leader>tc', new_buf, {});
vim.keymap.set({ 't' }, '<leader>td', delete_buf);
vim.keymap.set({ 't' }, '<leader>tda', delete_all_bufs);
vim.keymap.set({ 't' }, '<leader>th', prev_buf);
vim.keymap.set({ 't' }, '<leader>tl', next_buf);

vim.keymap.set({ 'n', 't' }, '<leader>t1', function() goto_buf(1); end, {});
vim.keymap.set({ 'n', 't' }, '<leader>t2', function() goto_buf(2); end, {});
vim.keymap.set({ 'n', 't' }, '<leader>t3', function() goto_buf(3); end, {});
vim.keymap.set({ 'n', 't' }, '<leader>t4', function() goto_buf(4); end, {});
vim.keymap.set({ 'n', 't' }, '<leader>t5', function() goto_buf(5); end, {});
