return {
  "lervag/vimtex",
  ft = { "tex", "bib" },
  config = function()
    vim.g.vimtex_view_method = "zathura"
    vim.g.vimtex_compiler_method = "latexmk"
    vim.g.vimtex_quickfix_enabled = 1
    vim.g.vimtex_view_general_viewer = "zathura"
    -- synctex forward-search escaping; verify with :VimtexView (runtime, not audited).
    vim.g.vimtex_view_general_options = "--unique file:@pdf\\#src:@line@tex"
    vim.g.tex_flavor = "latex"
  end,
}
