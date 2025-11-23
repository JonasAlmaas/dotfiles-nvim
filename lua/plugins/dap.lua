vim.api.nvim_create_augroup('DapGroup', {clear = true});

local function navigate(args)
	local buffer = args.buf

	local wid = nil
	local win_ids = vim.api.nvim_list_wins() -- Get all window IDs
	for _, win_id in ipairs(win_ids) do
		local win_bufnr = vim.api.nvim_win_get_buf(win_id)
		if win_bufnr == buffer then
			wid = win_id
		end
	end

	if wid == nil then
		return
	end

	vim.schedule(function()
		if vim.api.nvim_win_is_valid(wid) then
			vim.api.nvim_set_current_win(wid)
		end
	end)
end

local function create_nav_options(name)
	return {
		group = 'DapGroup',
		pattern = string.format('*%s*', name),
		callback = navigate
	}
end

return {
	{
		'mfussenegger/nvim-dap',
		dependencies = {
			'jedrzejboczar/nvim-dap-cortex-debug',
			'rcarriga/nvim-dap-ui',
			'theHamsta/nvim-dap-virtual-text',
			'nvim-neotest/nvim-nio',
			'williamboman/mason.nvim',
		},
		config = function()
			local dap = require('dap');
			local ui = require('dapui');

			require('dapui').setup();
			require('nvim-dap-virtual-text').setup();

			dap.set_log_level('DEBUG');

			vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, {desc = 'Debug: Toggle Breakpoint'})
			vim.keymap.set('n', '<leader>gb', dap.run_to_cursor, {desc = 'Debug: Run to cursor'});
			vim.keymap.set('n', '<leader>B', function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, {desc = 'Debug: Set Conditional Breakpoint'});

			vim.keymap.set('n', '<leader>?', function ()
				require('dapui').eval(nil, {enter=true});
			end);

			vim.keymap.set('n', '<F1>', dap.continue, {desc = 'Debug: Continue'});
			vim.keymap.set('n', '<F2>', dap.step_over, {desc = 'Debug: Step Over'});
			vim.keymap.set('n', '<F3>', dap.step_into, {desc = 'Debug: Step Into'});
			vim.keymap.set('n', '<F4>', dap.step_out, {desc = 'Debug: Step Out'});

			--vim.keymap.set('n', '<F8>', dap.continue, {desc = 'Debug: Continue'});
			--vim.keymap.set('n', '<F10>', dap.step_over, {desc = 'Debug: Step Over'});
			--vim.keymap.set('n', '<F11>', dap.step_into, {desc = 'Debug: Step Into'});
			--vim.keymap.set('n', '<F12>', dap.step_out, {desc = 'Debug: Step Out'});

			dap.listeners.before.attach.dapui_config = function()
				ui.open();
			end
			dap.listeners.before.launch.dapui_config = function()
				ui.open();
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				ui.close();
			end
			dap.listeners.before.event_exited.dapui_config = function()
				ui.close();
			end

			require('dap-cortex-debug').setup({
				debug = false,  -- log debug messages
				-- path to cortex-debug extension, supports vim.fn.glob
				-- by default tries to guess: mason.nvim or VSCode extensions
				extension_path = nil,
				lib_extension = nil, -- shared libraries extension, tries auto-detecting, e.g. 'so' on unix
				node_path = 'node', -- path to node.js executable
				dapui_rtt = true, -- register nvim-dap-ui RTT element
				-- make :DapLoadLaunchJSON register cortex-debug for C/C++, set false to disable
				dap_vscode_filetypes = { 'c', 'cpp' },
				rtt = {
					buftype = 'Terminal', -- 'Terminal' or 'BufTerminal' for terminal buffer vs normal buffer
				},
			});
			require('dap.ext.vscode').load_launchjs('.vscode/launch.json', nil);
		end
	},

	{
		'jay-babu/mason-nvim-dap.nvim',
		dependencies = {
			'williamboman/mason.nvim',
			'neovim/nvim-lspconfig',
		},
		config = function()
			require('mason-nvim-dap').setup({
				ensure_installed = {},
				automatic_installation = true,
				handlers = {
					function(config)
						require('mason-nvim-dap').default_setup(config)
					end,
				},
			})
		end,
	},
};
