-------------------------
-- Bootstrap lazy.nvim --
-------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-------------------------
-- Options and globals --
-------------------------

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.clipboard = "unnamedplus"

-- UI
vim.opt.number = true -- show line numbers
vim.opt.relativenumber = true -- show relative line numbers
vim.opt.cursorline = true -- highlight current line
vim.opt.termguicolors = true -- enable 24-bit RGB colors
vim.opt.signcolumn = "yes" -- always show sign column
vim.opt.updatetime = 200 -- faster UI response

-- Spaces & Tabs
vim.opt.tabstop = 4 -- number of visual spaces per tab
vim.opt.softtabstop = 4 -- number of spaces in tab when editing
vim.opt.shiftwidth = 4 -- auto indent is 4 spaces
vim.opt.expandtab = true -- tabs are spaces
vim.opt.smartindent = true -- smart indents

-- Search behavior
vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.smartcase = true -- ...unless a capital letter is used
vim.opt.hlsearch = true -- clear highlights after search

---------------------
-- Generic keymaps --
---------------------
local map = vim.keymap.set

-- Folding
map("n", "<leader><leader>", "za", { desc = "Toggle fold under cursor" })

-- Movement: move inside soft-wrapped lines unless a count is given
map("n", "j", [[v:count == 0 ? 'gj' : 'j']], { expr = true, silent = true })
map("n", "k", [[v:count == 0 ? 'gk' : 'k']], { expr = true, silent = true })

-- Filter current line or selection through external tool
map("v", "!", ":!", { desc = "Filter through external command" })

------------------
-- Autocommands --
------------------

local augroup = vim.api.nvim_create_augroup("UserConfig", { clear = true })

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup,
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	group = augroup,
	pattern = "*.py",
	callback = function()
		-- Organize imports
		vim.lsp.buf.code_action({
			context = { only = { "source.organizeImports" } },
			apply = true,
		})
		-- Format the buffer
		vim.lsp.buf.format({ async = false })
	end,
})

-------------
-- Plugins --
-------------

require("lazy").setup({
	spec = {
		-- theme
		{
			"sainnhe/gruvbox-material",
			lazy = false, -- load immediately
			priority = 1000, -- load first
			config = function()
				-- config variables before colorscheme command
				vim.g.gruvbox_material_background = "soft"
				vim.g.gruvbox_material_better_performance = 1
				-- apply
				vim.cmd.colorscheme("gruvbox-material")
			end,
		},
		-- statusline
		{
			"nvim-lualine/lualine.nvim",
			config = function()
				require("lualine").setup({
					options = {
						theme = "gruvbox-material",
						icons_enabled = false, -- no nerd font needed
						component_separators = "|",
						section_separators = "",
					},
				})
			end,
		},
		-- treesitter
		{
			"nvim-treesitter/nvim-treesitter",
			lazy = false,
			build = ":TSUpdate", -- update parsers after plugin update
			config = function()
				local langs = { "lua", "python", "vimdoc" }
				require("nvim-treesitter").install(langs)

				vim.api.nvim_create_autocmd("FileType", {
					pattern = langs,
					callback = function()
						-- Highlighting
						vim.treesitter.start()
						-- Folding
						vim.wo.foldmethod = "expr"
						vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
						vim.wo.foldlevel = 99
					end,
				})
			end,
		},
		-- LSP
		{
			"neovim/nvim-lspconfig",
			dependencies = { "hrsh7th/nvim-cmp" },
			config = function()
				local capabilities = require("cmp_nvim_lsp").default_capabilities()
				vim.lsp.config("ty", {
					cmd = { "ty", "server" },
					capabilities = capabilities,
				})
				vim.lsp.config("ruff", {
					cmd = { "ruff", "server" },
					capabilities = capabilities,
				})

				vim.lsp.enable("ty")
				vim.lsp.enable("ruff")

				vim.diagnostic.config({
					virtual_text = true,
					severity_sort = true,
					float = { border = "rounded", source = "always" },
				})

				vim.api.nvim_create_autocmd("LspAttach", {
					callback = function(args)
						map("n", "<leader>rn", vim.lsp.buf.rename, { buffer = args.buf, desc = "[R]e[n]ame variable" })
						map("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = args.buf, desc = "[C]ode [A]ction" })
						map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show [E]rror message" })
					end,
				})
			end,
		},
		-- completion
		{
			"hrsh7th/nvim-cmp",
			dependencies = {
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
			},
			config = function()
				local cmp = require("cmp")

				cmp.setup({
					mapping = cmp.mapping.preset.insert({
						["<C-b>"] = cmp.mapping.scroll_docs(-4),
						["<C-f>"] = cmp.mapping.scroll_docs(4),
						["<C-Space>"] = cmp.mapping.complete(),
						["<C-e>"] = cmp.mapping.abort(),
						["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept with Enter
						["<Tab>"] = cmp.mapping.select_next_item(), -- Cycle with Tab
						["<S-Tab>"] = cmp.mapping.select_prev_item(), -- Cycle back with Shift-Tab
					}),
					sources = cmp.config.sources({
						{ name = "nvim_lsp" },
					}, {
						{ name = "buffer", keyword_length = 3 },
						{ name = "path" },
					}),
				})
			end,
		},
		-- fuzzy findings
		{
			"nvim-telescope/telescope.nvim",
			dependencies = {
				"nvim-lua/plenary.nvim",
				{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			},
			keys = {
				{ "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find [F]iles" },
				{ "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Find by [G]rep" },
				{ "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Find [B]uffers" },
				{ "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Find [H]elp" },
				{ "<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>", desc = "Find [S]ymbols" },
				{ "<leader>fw", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", desc = "Find Symbols (Workspace)" },
				{ "gd", "<cmd>Telescope lsp_definitions<CR>", desc = "[G]oto [D]efinition" },
				{ "gr", "<cmd>Telescope lsp_references<CR>", desc = "[G]oto [R]eferences" },
				{ "gi", "<cmd>Telescope lsp_implementations<CR>", desc = "[G]oto [I]mplementation" },
				{ "<leader>q", "<cmd>Telescope diagnostics<CR>", desc = "Open [Q]uickfix list" },
			},
			config = function()
				require("telescope").setup({})
				require("telescope").load_extension("fzf")
			end,
		},
		-- pairs of '"{()}"'
		{
			"windwp/nvim-autopairs",
			event = "InsertEnter",
			config = true,
		},
		-- git in the signs column
		{
			"lewis6991/gitsigns.nvim",
			config = true,
		},
		-- surround commands
		{
			"kylechui/nvim-surround",
			version = "^3.0.0",
			event = "VeryLazy",
			config = true,
		},
	},
})
