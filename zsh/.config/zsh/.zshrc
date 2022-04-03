# General options
bindkey -v # vim mode
setopt autocd
unsetopt beep

# Completion
zstyle ':completion:*' completer _complete _ignored _correct _approximate
zstyle ':completion:*' max-errors 3 not-numeric
autoload -Uz compinit
compinit
_comp_options+=(globdots)
# Suggest packages when a command is not found
source /usr/share/doc/pkgfile/command-not-found.zsh

# History
HISTFILE=~/.cache/histfile
HISTSIZE=100000
SAVEHIST=$HISTSIZE

# Prompt (with git)
setopt PROMPT_SUBST
source /usr/share/git/completion/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=y
GIT_PS1_SHOWSTASHSTATE=y
GIT_PS1_SHOWUNTRACKEDFILES=y
PS1='%F{red}[ %F{yellow}%n %F{green}@ %F{cyan}%3~ %F{blue}]$(__git_ps1 " (%s)")%F{magenta} %(!.#.$) %f'

# Enable ls colors in foot terminal
# Doesn't really work though
eval $(env TERM=xterm256-color dircolors)

# History search with Ctrl-R
bindkey "^R" history-incremental-search-backward

# Add aliases
if [[ -r ~/.config/zsh/.aliasrc ]]; then
    source ~/.config/zsh/.aliasrc
fi

# Fish-like autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Syntax highlighting (always last)
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
