return {
	{
		'jay-babu/mason-nvim-dap.nvim',
		dependencies = {
			'williamboman/mason.nvim',
			'neovim/nvim-lspconfig',
		},
		config = function()
			require('mason-nvim-dap').setup({
				ensure_installed = {
					'cortex-debug',
					'codelldb'
				},
				automatic_installation = true,
				handlers = {
					function(config)
						require('mason-nvim-dap').default_setup(config)
					end,
				},
			})
		end,
	},

	{
		'mfussenegger/nvim-dap',
		dependencies = {
			'jedrzejboczar/nvim-dap-cortex-debug',
			'rcarriga/nvim-dap-ui',
			'theHamsta/nvim-dap-virtual-text',
			'nvim-neotest/nvim-nio',
			'williamboman/mason.nvim',
			'jay-babu/mason-nvim-dap.nvim',
		},
		config = function()
			local dap = require('dap');
			local ui = require('dapui');

			require('dapui').setup();
			require('nvim-dap-virtual-text').setup({});

			dap.set_log_level('DEBUG');

			vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
			vim.keymap.set('n', '<leader>gb', dap.run_to_cursor, { desc = 'Debug: Run to cursor' });
			vim.keymap.set('n', '<leader>B',
				function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
				{ desc = 'Debug: Set Conditional Breakpoint' });

			vim.keymap.set('n', '<leader>?', function()
				require('dapui').eval(nil, { enter = true });
			end);

			vim.keymap.set('n', '<F1>', dap.continue, { desc = 'Debug: Continue' });
			vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' });
			vim.keymap.set('n', '<F3>', dap.step_into, { desc = 'Debug: Step Into' });
			vim.keymap.set('n', '<F4>', dap.step_out, { desc = 'Debug: Step Out' });

			vim.keymap.set('n', '<leader>c', dap.continue, { desc = 'Debug: Continue' });
			vim.keymap.set('n', '<leader>n', dap.step_over, { desc = 'Debug: Step Over' });
			vim.keymap.set('n', '<leader>i', dap.step_into, { desc = 'Debug: Step Into' });
			vim.keymap.set('n', '<leader>o', dap.step_out, { desc = 'Debug: Step Out' });
			vim.keymap.set('n', '<leader>s', dap.stop, { desc = 'Debug: Stop' });

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

			local mason_root = require("mason.settings").current.install_root_dir;

			-- Setup codelldb adapter if installed
			local codelldb_path = mason_root .. '/packages/codelldb/extension';
			local codelldb_bin = codelldb_path .. "/adapter/codelldb"
			dap.adapters.codelldb = {
				type = "server",
				port = "${port}",
				executable = {
					command = codelldb_bin,
					args = { "--port", "${port}" },
				}
			}

			-- Rust configuration
			dap.configurations.rust = {
				{
					name = "Launch",
					type = "codelldb",
					request = "launch",
					program = function()
						return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
					end,
					cwd = '${workspaceFolder}',
					stopOnEntry = false,
				},
			}

			require('dap-cortex-debug').setup({
				debug = false, -- log debug messages
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
			--require('dap.ext.vscode').load_launchjs('.vscode/launch.json', nil);
		end
	},
};
