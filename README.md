# Justin's Dot Files

## Soft link (MacOS)

- `nvim` -> `~/.config/nvim`
- `ghostty` -> `~/.config/ghostty`
- `lazygit/config.yml` -> `~/Library/Application Support/lazygit/config.yml`

## Prerequisites

### Neovim

Requires **Neovim >= 0.12**.

```sh
# build treesitter parsers
brew install tree-sitter-cli

# C/C++ language server: clangd (Xcode command line tools ship it; `brew install llvm` also works)
# fzf-lua deps (delta is also the lazygit pager, chafa is optional image preview)
brew install fzf ripgrep fd delta chafa
```

#### macOS: free the <kbd>⌃</kbd>+<kbd>arrow</kbd> shortcuts

Window nav/resize uses <kbd>⌃</kbd>+<kbd>←</kbd> <kbd>→</kbd> <kbd>↑</kbd> <kbd>↓</kbd>, but macOS
eats those before nvim sees them.  
Uncheck in **System Settings → Keyboard → Keyboard Shortcuts… → Mission Control**:

- [ ] Mission Control — <kbd>⌃</kbd>+<kbd>↑</kbd>
- [ ] Application windows — <kbd>⌃</kbd>+<kbd>↓</kbd>
- [ ] Move left a space — <kbd>⌃</kbd>+<kbd>←</kbd>
- [ ] Move right a space — <kbd>⌃</kbd>+<kbd>→</kbd>
