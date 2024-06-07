vim.g.mapleader = "," -- Make sure to set `mapleader` before lazy so your mappings are correct

vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = false
vim.opt.colorcolumn = "80"

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = { style = "storm" },
	},
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			icons_enabled = true,
			theme = "auto",
		},
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 200
		end,
	},
	{
		"github/copilot.vim",
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.4",
		opts = {
			extensions = { fzf },
		},
		config = function()
			local builtin = require("telescope.builtin")
			local keymap = vim.keymap.set

			keymap("n", "<leader>ff", builtin.find_files, {})
			keymap("n", "<leader>fg", builtin.live_grep, {})
			keymap("n", "<leader>fb", builtin.buffers, {})
			keymap("n", "<leader>fh", builtin.help_tags, {})
		end,
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")
			local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

			parser_config.zpl = {
				install_info = {
					url = "/Users/cdmwebs/src/knowndecimal/tree-sitter-zpl",
					files = { "src/parser.c" },
				},
				filetype = "zpl",
			}

			configs.setup({
				ensure_installed = {
					"lua",
					"ruby",
					"python",
					"elixir",
					"vim",
					"vimdoc",
					"javascript",
					"typescript",
					"tsx",
					"html",
					"css",
					"json",
					"yaml",
					"bash",
					"php",
					"dockerfile",
					"heex",
					"toml",
				},
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
	"nvim-lua/plenary.nvim",
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = { "stylua", "shfmt" },
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			diagnostics = {
				virtual_text = true,
			},
		},
		config = function()
			local lspconfig = require("lspconfig")
			local keymap = vim.keymap.set
			local opt = { noremap = true, silent = true }

			keymap("n", ",e", vim.diagnostic.open_float, opt)
			keymap("n", "K", vim.lsp.buf.hover, opt)

			lspconfig.phpactor.setup({
				cmd = { "phpactor", "language-server" },
				filetypes = { "php" },
				root_dir = lspconfig.util.root_pattern("composer.json", ".git"),
			})

			lspconfig.standardrb.setup({
				cmd = { "standardrb", "--lsp" },
				filetypes = { "ruby" },
				root_dir = lspconfig.util.root_pattern("Gemfile", ".git"),
			})

			lspconfig.pylsp.setup({
				cmd = { "pylsp" },
				filetypes = { "python" },
				root_dir = lspconfig.util.root_pattern("requirements.txt", ".git"),
			})

			lspconfig.elixirls.setup({
				cmd = { "elixir-ls" },
				filetypes = { "elixir" },
				root_dir = lspconfig.util.root_pattern("mix.exs", ".git"),
			})
		end,
	},
	"jose-elias-alvarez/null-ls.nvim",
	"jay-babu/mason-null-ls.nvim",
	"ms-jpq/coq_nvim",
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				-- Customize or remove this keymap to your liking
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
		-- Everything in opts will be passed to setup()
		opts = {
			-- Define your formatters
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "black" },
				javascript = { { "prettier", "prettierd" } },
				html = { { "prettier", "prettierd" } },
				php = { "pint" },
				ruby = { "standardrb" },
			},
			-- Set up format-on-save
			format_on_save = { timeout_ms = 500, lsp_fallback = true },
			-- Customize formatters
			formatters = {
				shfmt = {
					prepend_args = { "-i", "2" },
				},
			},
		},
		init = function()
			-- If you want the formatexpr, here is the place to set it
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		end,
	},
	"lewis6991/gitsigns.nvim",
})

vim.opt.termguicolors = true
vim.cmd.colorscheme("tokyonight")
