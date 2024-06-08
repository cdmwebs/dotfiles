# dotfiles

These are my dotfiles. There are many like them but these are mine. I'm using
[GNU Stow] to manage the installation.

### zsh

I use [zinit] for plugin management.

### tmux

There are a couple tmux pacakges. Open tmux and use `<C-b> I` to install.

### Neovim

Configs are managed via [lazy.nvim]. Open nvim and use `:Lazy` to update/sync/etc.

[Mason] and [lspconfig] handle the LSPs and formatters.

### Alacritty

I'm using [Alacritty](https://github.com/alacritty/alacritty) for terminal. I've got
[alacritty-theme] included as a submodule
for theme switching.

## Installation

Make sure `stow` is installed.

```sh
git clone git@github.com:cdmwebs/dotfiles.git
cd dotfiles
git submodule update --init --recursive
stow .
```

[zinit]: https://github.com/zdharma-continuum/zinit
[lazy.nvim]: https://github.com/folke/lazy.nvim
[GNU Stow]: https://www.gnu.org/software/stow/
[Mason]: https://github.com/williamboman/mason.nvim
[lspconfig]: https://github.com/neovim/nvim-lspconfig
[Alacritty]: https://github.com/alacritty/alacritty
[alacritty-theme]: https://github.com/alacritty/alacritty-theme
