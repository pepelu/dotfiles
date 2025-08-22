# Store zsh config files under .config
export ZDOTDIR=$HOME/.config/zsh

# Default programs
export EDITOR=vim
export VISUAL=vim
export BROWSER=firefox

# Support color escape codes in less
# Useful for things like jq
export LESS='-R '

# Add ~/.local/bin to path per file-hierarchy(7)
typeset -U PATH path     # discard duplicates, see zshbuiltins(1)
path=(~/.local/bin $path)
export PATH
