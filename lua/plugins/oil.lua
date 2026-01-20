return {
	'stevearc/oil.nvim',
	opts = {},
	dependencies = { { "nvim-mini/mini.icons", opts = {} } },
	-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
	lazy = false,
	config = function()
		require('oil').setup({
			view_options = {
				show_hidden = true,
				--[[is_always_hidden = function(name, bufno)
					return name == '.git';
				end,]]
			}
		});
	end
};
