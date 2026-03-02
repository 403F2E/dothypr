return {
  {
    "stevearc/conform.nvim",
    event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- test new blink
  { import = "nvchad.blink.lazyspec" },

  -- Treesitter plagin
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "vimdoc",
        "lua",
        "html",
        "css",
        "python",
        "rust",
        "java",
        "javascript",
        "typescript",
        "tsx",
        "dockerfile",
        "bash",
        "c",
        "cpp",
        "markdown",
      },
    },
  },
  
  	-- Markdown preview plugin
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},

  -- Git plugin for nvim 
	{
		"tpope/vim-fugitive",
		cmd = { "Git", "Gedit", "Gsplit", "Gdiffsplit" },
		lazy = false,
	},

  	-- php configuration
	{
		"jwalton512/vim-blade",
		ft = { "php", "blade.php" },
		config = function()
			vim.g.blade_custom_delimiters = { php = { "{{", "}}" } } -- Laravel-style syntax
		end,
	},

  -- python lsp configuration
	{
		"microsoft/pyright",
		ft = { "python" },
	},

  -- Rust plugin 
  {
		"rust-lang/rust-analyzer",
		lazy = false,
	},
  {
		"rust-lang/rust.vim",
		ft = "rust",
		init = function()
			vim.g.rustfmt_autosave = 1
		end,
	},
  --- Crates plugin for the Cargo.toml file
  {
		"saecki/crates.nvim",
		ft = { "toml" },
		config = function()
			require("crates").setup()
		end,
	},

	-- java lsp plugin configuration
	{
		"mfussenegger/nvim-jdtls",
		ft = { "java" },
	},

	-- flutter lsp configuration
	{
		"nvim-flutter/flutter-tools.nvim",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"stevearc/dressing.nvim", -- optional for vim.ui.select
		},
		config = true,
	},
}
