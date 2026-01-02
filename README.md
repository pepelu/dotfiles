# Dotfiles

My own set of configuration files.

## Details

- Compositor: [Sway](https://swaywm.org/).
- Document viewer: [zathura](https://pwmt.org/projects/zathura/).
- Editor: [vim](https://www.vim.org/) and [Neovim](https://neovim.io/).
- Shell: [Zsh](https://www.zsh.org/).
- Terminal: [foot](https://codeberg.org/dnkl/foot).

## Install

Vim plugins are managed with [vim-plug](https://github.com/junegunn/vim-plug). The plugin manager will be automatically installed the first time you run vim after deploying the configuration files. The plugin manager will then install the plugins.

Neovim plugins are manager with [lazy.nvim](https://github.com/folke/lazy.nvim). Same as with Vim, the plugin manager will be automatically installed on first run.

You can install the configuration files for each application with [GNU Stow](https://www.gnu.org/software/stow/):

1. Clone the repository: `git clone https://github.com/pepelu/dotfiles.git ~/dotfiles`.
1. Enter the directory `cd dotfiles`.
1. Deploy the configuration files for the application you want, e.g. for zsh: `stow zsh`.

You can remove a configuration package, adding the `-D` flag: `stow -D zsh`.
