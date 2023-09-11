local lazy = {}

function lazy.install(path)
	if not vim.loop.fs_stat(path) then
		print('Installing lazy.nvim....')
		vim.fn.system({
			'git',
			'clone',
			'--filter=blob:none',
			'https://github.com/folke/lazy.nvim.git',
			'--branch=stable', -- latest stable release
			path,
		})
	end
end

function lazy.setup(plugins)
	-- You can "comment out" the line below after lazy.nvim is installed
	lazy.install(lazy.path)

	vim.opt.rtp:prepend(lazy.path)
	require('lazy').setup(plugins, lazy.opts)
end

lazy.path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
lazy.opts = {}

-- Example using a list of specs with the default options
vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

-- :Lazy - open lazy.nvim menu
lazy.setup({
	{ 'neovim/nvim-lspconfig' },     -- LSP configurations
	{ 'williamboman/mason.nvim' },   -- Installer for external tools
	{ 'williamboman/mason-lspconfig.nvim' }, -- mason extension for lspconfig
	{ 'hrsh7th/nvim-cmp' },          -- Autocomplete engine
	{ 'hrsh7th/cmp-nvim-lsp' },      -- Completion source for LSP
	{ 'L3MON4D3/LuaSnip' },          -- Snippet engine
	{ 'ellisonleao/gruvbox.nvim' },  -- colorscheme
	{ 'tpope/vim-commentary' },
	{ 'tpope/vim-surround' },
	{ 'tpope/vim-fugitive' },
	{ 'github/copilot.vim' },
	{ 'lewis6991/gitsigns.nvim' },
	{
		'nvim-telescope/telescope.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		}
	},
	{ 'fatih/vim-go' },
})

require('gitsigns').setup()
require("gruvbox").setup({ contrast = "hard" })

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>p', builtin.git_files, {})
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>rg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

vim.cmd([[
  colorscheme gruvbox
  set background=dark

  " what is this?
  " set signcolumn=yes

  set number
  set relativenumber

  " map leader to Space
  " let mapleader = " "

  " map escape to kj
  inoremap kj <ESC>

  " cancel search term highlights
  nnoremap <leader>j :noh<CR>

  " open quicklist
  nnoremap <leader>co :copen<CR>

  " close quicklist
  nnoremap <leader>cc :cclose<CR>

  " Next item on quicklist
  nnoremap <leader>cn :cn<cr>

  " Previous item on quicklist
  nnoremap <leader>cp :cp<cr>

  " *** Neotree config ***
  nnoremap <leader>b :Neotree toggle<CR>

  "**** indentation by file type ****
  " by default, the indent is 2 spaces.
  set shiftwidth=2
  set softtabstop=2
  set tabstop=2
  autocmd Filetype html setlocal ts=2 sw=2 expandtab
  autocmd Filetype javascript setlocal ts=2 sw=2 sts=0 expandtab
  autocmd Filetype python setlocal ts=4 sw=4 sts=0 expandtab
  autocmd Filetype go setlocal ts=8 sw=8 sts=0 expandtab
]])

local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
	sources = {
		{ name = 'nvim_lsp' },
	},
	mapping = cmp.mapping.preset.insert({
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-u>'] = cmp.mapping.scroll_docs(-4),
		['<C-d>'] = cmp.mapping.scroll_docs(4),
	}),
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end
	},
})

local lsp_cmds = vim.api.nvim_create_augroup('lsp_cmds', { clear = true })

vim.api.nvim_create_autocmd('LspAttach', {
	group = lsp_cmds,
	desc = 'LSP actions',
	callback = function()
		local bufmap = function(mode, lhs, rhs)
			vim.keymap.set(mode, lhs, rhs, { buffer = true })
		end

		bufmap('n', '<leader>k', '<cmd>lua vim.lsp.buf.hover()<cr>')
		bufmap('n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
		bufmap('n', '<leader>gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
		bufmap('n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
		bufmap('n', '<leader>gt', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
		bufmap('n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<cr>')
		bufmap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>')
		bufmap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>')
		bufmap('n', '<leader>da', '<cmd>lua vim.diagnostic.open_float()<cr>')
		bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
		bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
		bufmap({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>') -- TODO
	end
})

local lspconfig = require('lspconfig')
local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities = vim.tbl_deep_extend(
	'force',
	lsp_defaults.capabilities,
	require('cmp_nvim_lsp').default_capabilities()
)

require('mason').setup({})
require('mason-lspconfig').setup({
	ensure_installed = {
		'tsserver',
		'eslint',
		'html',
		'cssls',
		'gopls',
	},
	handlers = {
		function(server)
			lspconfig[server].setup({})
		end,
		['tsserver'] = function()
			lspconfig.tsserver.setup({
				settings = {
					completions = {
						completeFunctionCalls = true
					}
				}
			})
		end
	}
})
