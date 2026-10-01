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

# fzf-lua deps (delta is also the lazygit pager, chafa is optional image preview)
brew install fzf ripgrep fd delta chafa
```

#### macOS: free `<C-arrow>`

Window nav/resize uses `<C-arrow>`, but macOS eats those before nvim sees them.
Uncheck in **System Settings → Keyboard → Keyboard Shortcuts… → Mission Control**:

- [ ] Mission Control — `ctrl`+`up`
- [ ] Application windows — `ctrl`+`down`
- [ ] Move left a space — `ctrl`+`left`
- [ ] Move right a space — `ctrl`+`right`
