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

if #vim.v.argv <= 2 then
	vim.api.nvim_create_autocmd("VimEnter", {
		callback = function()
			vim.cmd("Neotree")
		end,
	})
end
