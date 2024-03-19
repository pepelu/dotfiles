# Dotfiles

My own set of configuration files.

## Details

- Compositor: [Sway](https://swaywm.org/).
- Document viewer: [zathura](https://pwmt.org/projects/zathura/).
- Editor: [vim](https://www.vim.org/).
    - [gruvbox-material](https://github.com/sainnhe/gruvbox-material).
    - [lightline](https://github.com/itchyny/lightline.vim).
    - [vim-unimpaired](https://github.com/tpope/vim-unimpaired).
    - [vim-wayland-clipboard](https://github.com/jasonccox/vim-wayland-clipboard).
- Shell: [Zsh](https://www.zsh.org/).
- Terminal: [foot](https://codeberg.org/dnkl/foot).

## Install

Vim plugins are managed with [vim-plug](https://github.com/junegunn/vim-plug). The plugin manager will be automatically installed the first time you run vim after deploying the configuration files. The plugin manager will then install the plugins.

You can install the configuration files for each application with [GNU Stow](https://www.gnu.org/software/stow/):

1. Clone the repository: `git clone --recurse-submodules https://github.com/pepelu/dotfiles.git ~/dotfiles`.
1. Enter the directory `cd dotfiles`.
1. Deploy the configuration files for the application you want, e.g. for zsh: `stow zsh`.

You can remove a configuration package, adding the `-D` flag: `stow -D zsh`.
