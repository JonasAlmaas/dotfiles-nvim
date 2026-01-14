return {
	'nvim-telescope/telescope.nvim',
	tag = 'v0.2.0',
	dependencies = { 'nvim-lua/plenary.nvim' },
	keys = {
		{ "<leader>ff", mode = "n" },
		{ "<leader>fg", mode = "n" },
		{ "<leader>fb", mode = "n" },
		{ "<leader>vh", mode = "n" },
	},
	cmd = "Telescope",
	config = function()
		require('telescope').setup({});

		local builtin = require('telescope.builtin');

		vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' });
		--[[vim.keymap.set('n', '<C-p>', function() builtin.git_files({ show_untracked = true }); end,
			{ desc = 'Telescope git files', });]]
		vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' });
		vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' });

		--[[vim.keymap.set('n', '<leader>pws', function()
			local word = vim.fn.expand("<cword>")
			builtin.grep_string({ search = word })
		end);
		vim.keymap.set('n', '<leader>pWs', function()
			local word = vim.fn.expand("<cWORD>")
			builtin.grep_string({ search = word })
		end);
		vim.keymap.set('n', '<leader>ps', function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end);]]
		vim.keymap.set('n', '<leader>vh', builtin.help_tags, {});
	end
}
