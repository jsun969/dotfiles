# Justin's Dot Files

## Soft link (MacOS)

- `nvim` -> `~/.config/nvim`
- `ghostty` -> `~/.config/ghostty`
- `lazygit/config.yml` -> `~/Library/Application Support/lazygit/config.yml`

## Prerequisites (MacOS)

`nvim` needs **Neovim >= 0.12** and, for treesitter parser builds:

```
brew install tree-sitter-cli
```

Note `tree-sitter` (the library) is a different formula than `tree-sitter-cli`
(the parser generator). nvim-treesitter's `main` branch shells out to
`tree-sitter build` for every install, so only the CLI works. A C compiler must
also be on PATH (Xcode CLT `cc` is enough).
