-- clangd for C/C++: the binary ships with the Xcode command line tools (brew
-- llvm also provides it), so there is nothing for mason to install -- just
-- enable the server. nvim-lspconfig supplies the client config.
vim.lsp.enable("clangd")
