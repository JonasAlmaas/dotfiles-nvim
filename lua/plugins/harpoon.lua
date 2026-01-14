return {
	'ThePrimeagen/harpoon',
	branch = 'harpoon2',
	dependencies = {
		'nvim-lua/plenary.nvim',
		--'nvim-telescope/telescope.nvim',
	},
	keys = {
		{ "<leader>a", mode = "n" },
		{ "<leader>hh", mode = "n" },
		{ "<leader>ha", mode = "n" },
		{ "<leader>hs", mode = "n" },
		{ "<leader>hd", mode = "n" },
		{ "<leader>hf", mode = "n" },
		{ "<leader>h1", mode = "n" },
		{ "<leader>h2", mode = "n" },
		{ "<leader>h3", mode = "n" },
		{ "<leader>h4", mode = "n" },
		{ "<leader>hp", mode = "n" },
		{ "<leader>hn", mode = "n" },
	},
	config = function()
		local harpoon = require("harpoon");
		local extensions = require("harpoon.extensions");

		harpoon:setup({});

		-- Keymapping
		vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end);
		--vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end);
		vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end);

		vim.keymap.set("n", "<leader>ha", function() harpoon:list():select(1) end);
		vim.keymap.set("n", "<leader>hs", function() harpoon:list():select(2) end);
		vim.keymap.set("n", "<leader>hd", function() harpoon:list():select(3) end);
		vim.keymap.set("n", "<leader>hf", function() harpoon:list():select(4) end);

		vim.keymap.set("n", "<leader>h1", function() harpoon:list():select(1) end);
		vim.keymap.set("n", "<leader>h2", function() harpoon:list():select(2) end);
		vim.keymap.set("n", "<leader>h3", function() harpoon:list():select(3) end);
		vim.keymap.set("n", "<leader>h4", function() harpoon:list():select(4) end);

		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "<leader>hp", function() harpoon:list():prev() end);
		vim.keymap.set("n", "<leader>hn", function() harpoon:list():next() end);

		-- Extensions
		harpoon:extend(extensions.builtins.navigate_with_number());
		harpoon:extend(extensions.builtins.highlight_current_file());

		-- Use telescope as the UI
		--[[local conf = require("telescope.config").values;
		local function toggle_telescope(harpoon_files)
			local file_paths = {};
			for _, item in ipairs(harpoon_files.items) do
				table.insert(file_paths, item.value);
			end

			require("telescope.pickers").new({}, {
				prompt_title = "Harpoon",
				finder = require("telescope.finders").new_table({
					results = file_paths,
				}),
				previewer = conf.file_previewer({}),
				sorter = conf.generic_sorter({}),
			}):find();
		end

		--vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end);
		vim.keymap.set("n", "<leader>hh", function() toggle_telescope(harpoon:list()) end);]]
	end
};
