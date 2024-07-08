-- Automaticallly run: PackerCompile

return require('packer').startup(function(use)
	use( 'wbthomason/packer.nvim' )

	use( 'neovim/nvim-lspconfig')
	use( 'hrsh7th/cmp-nvim-lsp' )
	use( 'hrsh7th/cmp-buffer'   )
	use( 'hrsh7th/cmp-path'     )
	use( 'hrsh7th/cmp-cmdline'  )
	use( 'hrsh7th/nvim-cmp'     )
    use('EdenEast/nightfox.nvim')
    --Git
    use('tpope/vim-fugitive')
    use("lewis6991/gitsigns.nvim")

    use("williamboman/mason.nvim")
    use("williamboman/mason-lspconfig.nvim")
	use( 'mfussenegger/nvim-jdtls')
	use'kabouzeid/nvim-lspinstall'

	use('nvim-lua/plenary.nvim')
	use {
  	'nvim-telescope/telescope.nvim', tag = '0.1.5',
-- or                            , branch = '0.1.x',
  	requires = { {'nvim-lua/plenary.nvim'} }
	}use('nvim-tree/nvim-web-devicons')

	use('nvim-treesitter/nvim-treesitter')
	use("L3MON4D3/LuaSnip")
	use('saadparwaiz1/cmp_luasnip')
	use("folke/tokyonight.nvim")
	use("rebelot/kanagawa.nvim")
	use({
	    'ramojus/mellifluous.nvim',
	    -- version = "v0.*", -- uncomment for stable config (some features might be missed if/when v1 comes out)
	    config = function()
		require'mellifluous'.setup({}) -- optional, see configuration section.
	    end,
	})

	use( "stevearc/oil.nvim" )
	use( "C:\\Users\\jesse\\AppData\\Local\\nvim\\custom_plugins\\Runner" )
end)

