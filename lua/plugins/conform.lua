return {
	'stevearc/conform.nvim',
	opts = {},
	config = function()
		require('conform').setup({
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				svelte = { "prettier" },
			},
		});

		vim.keymap.set("n", "<leader>fd", function()
			require("conform").format({ bufnr = 0 }); -- Format current buffer (0)
		end);
	end
};
