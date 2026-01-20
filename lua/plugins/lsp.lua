return {
	{
		'neovim/nvim-lspconfig',
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',
			'hrsh7th/nvim-cmp',
			'hrsh7th/cmp-nvim-lsp',
			'j-hui/fidget.nvim',
		},
		config = function()
			local cmp = require('cmp');
			local cmp_lsp = require('cmp_nvim_lsp');
			local capabilities = vim.tbl_deep_extend(
				'force',
				{},
				vim.lsp.protocol.make_client_capabilities(),
				cmp_lsp.default_capabilities());

			require('fidget').setup({});

			-- Make float borders visible
			vim.api.nvim_set_hl(0, 'FloatBorder', { fg = '#ffffff', bg = 'NONE' });
			vim.api.nvim_set_hl(0, 'NormalFloat', { bg = '#1a1a1a' });

			require('mason').setup({});
			require('mason-lspconfig').setup({
				ensure_installed = {
					'clangd',
					'csharp_ls',
					'lua_ls',
					'rust_analyzer',
					'svelte',
					'tailwindcss',
					'ts_ls',
				},
			});

			vim.lsp.config('clangd', { capabilities = capabilities });
			vim.lsp.config('csharp_ls', { capabilities = capabilities });
			vim.lsp.config('rust_analyzer', { capabilities = capabilities });
			vim.lsp.config('svelte', { capabilities = capabilities });
			vim.lsp.config('tailwindcss', {
				capabilities = capabilities,
				filetype = {
					'html', 'css',
					'javascript', 'typescript',
					'svelte',
				}
			});
			vim.lsp.config('ts_ls', { capabilities = capabilities });

			local cmp_select = { behavior = cmp.SelectBehavior.Select };

			cmp.setup({
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
					['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
					['<C-y>'] = cmp.mapping.confirm({ select = true }),
					['<Tab>'] = cmp.mapping.confirm({ select = true }),
					['<C-Space>'] = cmp.mapping.complete(), -- Does not work in Windows terminal by default
					['<C-e>'] = cmp.mapping.complete(),
				}),
				sources = cmp.config.sources(
					{ { name = 'nvim_lsp' } },
					{ { name = 'buffer' } }),
			});

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
			});
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
