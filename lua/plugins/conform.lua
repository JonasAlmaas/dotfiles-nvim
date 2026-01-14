return {
	'stevearc/conform.nvim',
	event = { "BufWritePre" },
	keys = {
		{ "<leader>fd", mode = "n" },
	},
	cmd = "ConformInfo",
	opts = {},
	config = function()
		require('conform').setup({
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				svelte = { "prettier" },
			},
			default_format_opts = {
				lsp_format = "fallback",
			},
		});

		vim.keymap.set("n", "<leader>fd", function()
			require("conform").format({ bufnr = 0 }); -- Format current buffer (0)
		end);
	end
};
