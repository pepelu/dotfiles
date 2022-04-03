# Dotfiles

My own set of configuration files.

## Details

- Compositor: [Sway](https://swaywm.org/).
- Document viewer: [zathura](https://pwmt.org/projects/zathura/).
- Editor: [vim](https://www.vim.org/).
    - [gruvbox-material](https://github.com/sainnhe/gruvbox-material).
    - [lightline](https://github.com/itchyny/lightline.vim).
    - [vim-wayland-clipboard](https://github.com/jasonccox/vim-wayland-clipboard).
- Shell: [Zsh](https://www.zsh.org/).
- Terminal: [foot](https://codeberg.org/dnkl/foot).

## Install

The vim plugins are tracked as [git submodules](https://git-scm.com/book/en/v2/Git-Tools-Submodules). You can clone the repository and automatically initialize the submodules passing `--recurse-submodules` to `git clone`.

You can install the configuration files for each application with [GNU Stow](https://www.gnu.org/software/stow/):

1. Clone the repository: `git clone --recurse-submodules https://github.com/pepelu/dotfiles.git ~/dotfiles`.
1. Enter the directory `cd dotfiles`.
1. Deploy the configuration files for the application you want, e.g. for zsh: `stow zsh`.

You can remove a configuration package, adding the `-D` flag: `stow -D zsh`.
