-- nvim ships no nix indenter; use nvim-treesitter's indents.scm
vim.b.did_indent = true
vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
