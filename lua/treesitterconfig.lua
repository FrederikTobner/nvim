require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "c", "lua", "rust", "java"},
  auto_install = true,
   highlight = {
    -- `false` will disable the whole extension
    enable = true,
   },
}