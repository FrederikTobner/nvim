require'lspconfig'.clangd.setup{}
-- npm install -g typescript typescript-language-server
require'lspconfig'.tsserver.setup{}
-- npm i -g vscode-langservers-extracted
require'lspconfig'.html.setup {}
require'lspconfig'.cssls.setup {}
require'lspconfig'.jsonls.setup {}
-- Marksman language server (for markdown syntax)
require'lspconfig'.marksman.setup {}
-- Vim script language server provider 
require'lspconfig'.vimls.setup {}