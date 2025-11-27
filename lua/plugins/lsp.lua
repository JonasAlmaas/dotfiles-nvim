return {
	{
		'neovim/nvim-lspconfig',
		dependencies = {
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',
			'hrsh7th/nvim-cmp',
			'hrsh7th/cmp-nvim-lsp',
			'j-hui/fidget.nvim',
		},
		config = function()
			local cmp_lsp = require('cmp_nvim_lsp');
			local capabilities = vim.tbl_deep_extend(
				'force',
				{},
				vim.lsp.protocol.make_client_capabilities(),
				cmp_lsp.default_capabilities());

			require('cmp').setup({});
			require('fidget').setup({});

			require('mason').setup({});
			require('mason-lspconfig').setup({
				ensure_installed = {
					'clangd',
					'csharp_ls',
					'lua_ls',
					'tailwindcss',
					'ts_ls',
				},
			});

			vim.lsp.config('clangd', {capabilities = capabilities});
			vim.lsp.config('csharp_ls', {capabilities = capabilities});
			vim.lsp.config('tailwindcss', {
				capabilities = capabilities,
				filetype = {
					'html', 'css',
					'javascript', 'typescript',
					'svelte',
				}
			});
			vim.lsp.config('ts_ls', {capabilities = capabilities});

			vim.diagnostic.config({
				-- update_in_insert = true,
				float = {
					focusable = false,
					style = "minimal",
					border = "rounded",
					source = true,
					header = "",
					prefix = "",
				},
			})
		end
	},
	{ -- Lua LSP stuff
		{
			"folke/lazydev.nvim",
			ft = "lua", -- only load on lua files
			opts = {
				library = {
					-- See the configuration section for more details
					-- Load luvit types when the `vim.uv` word is found
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		}
	}
}
