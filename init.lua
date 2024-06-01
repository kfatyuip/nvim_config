local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')

Plug('neoclide/coc.nvim', { ['branch'] = 'master', ['do'] = 'npm ci' })
Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope.nvim', { ['tag'] = '0.1.6' })
Plug('folke/tokyonight.nvim')
Plug('MunifTanjim/nui.nvim')
Plug('nvim-lualine/lualine.nvim')
Plug('nvim-tree/nvim-web-devicons')
Plug('nvim-neo-tree/neo-tree.nvim',
	{ ['branch'] = 'v3.x', ['requires'] = { 'nvim-lua/plenary.nvim', 'MunifTanjim/nui.nvim' } })
Plug('skywind3000/asyncrun.vim')
Plug('nvim-tree/nvim-web-devicons')
Plug('ryanoasis/vim-devicons')
Plug('akinsho/bufferline.nvim', { ['tag'] = '*' })
Plug('shellRaining/hlchunk.nvim', { ['event'] = { 'BufReadPre', 'BufNewFile' } })

vim.call('plug#end')

require('options/cocnvim')
require('option')

vim.cmd [[colorscheme tokyonight-storm]]

require('neo-tree').setup({
	enable_git_status = true,
	window = {
		position = "left",
	},
	default_component_config = {
		name = {
			use_git_status_colors = true
		},
		git_status = {
			symbols = {
				-- Change type
				added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
				modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
				deleted   = "✖", -- this can only be used in the git_status source
				renamed   = "󰁕", -- this can only be used in the git_status source
				-- Status type
				untracked = "",
				ignored   = "",
				unstaged  = "󰄱",
				staged    = "",
				conflict  = "",
			}
		}
	},
	git_status = {
		window = {
			position = "float",
			mappings = {
				["A"]  = "git_add_all",
				["gu"] = "git_unstage_file",
				["ga"] = "git_add_file",
				["gr"] = "git_revert_file",
				["gc"] = "git_commit",
				["gp"] = "git_push",
				["gg"] = "git_commit_and_push",
			}
		}
	}
})

vim.cmd([[nnoremap \ :Neotree reveal<cr>]])
vim.cmd([[nnoremap \g :Neotree float git_status<cr>]])

require('lualine').setup {
	options = { theme = 'horizon' }
}

require("bufferline").setup {}

require('hlchunk').setup({
	chunk = {
		enable = true,
	},
	indent = {
		enable = true
	}
})
