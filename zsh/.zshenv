# Store zsh config files under .config
export ZDOTDIR=$HOME/.config/zsh

# Default programs
export EDITOR=vim
export VISUAL=vim
export BROWSER=firefox

# Code syntax coloring in less (requires source-highlight)
export LESSOPEN="| /usr/bin/source-highlight-esc.sh %s"
export LESS='-R '

# Add ~/.local/bin to path per file-hierarchy(7)
typeset -U PATH path     # discard duplicates, see zshbuiltins(1)
path=(~/.local/bin $path)
export PATH
