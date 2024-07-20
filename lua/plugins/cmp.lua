local cmp = require("cmp")
local servers = { "lua_ls", "clangd", "taplo", "pyright", "yamlls", "zk", "jsonls", "html", "eslint" }

local on_attach = function(client, bufnr)
  client.resolved_capabilities.document_formatting = false

  local opts = { noremap=true, silent=true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>Telescope lsp_definitions<CR>', opts)
end

local on_init = function(client)
  client.server_capabilities.workspace = {
    workspace_folders = true,
  }
end


local lspconfig = require("lspconfig")
for _, lsp in pairs(servers) do
    lspconfig[lsp].setup {
  		on_attach = on_attach,
		on_init = on_init,
	}
end

cmp.setup({
	mapping = cmp.mapping.preset.insert({
		["TAB"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif vim.api.nvim_check_var("b:did_indent", 1) then
				fallback()
			end
		end, {"i", "s"}),
		["<S-TAB>"] = cmp.mapping(function()
			if cmp.visible() then
				cmp.select_prev_item()
			end
		end, {"i", "s"}),
    	['<C-b>'] = cmp.mapping.scroll_docs(-4),
	    ['<C-f>'] = cmp.mapping.scroll_docs(4),
	    ['<C-Space>'] = cmp.mapping.complete(),
	    ['<C-e>'] = cmp.mapping.abort(),
	    ['<CR>'] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({
		{name = "nvim_lsp"},
		{name = "buffer"},
		{name = "path"},
	},{
		{name =  "calc"},
	}),
})
