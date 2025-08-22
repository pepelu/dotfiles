# General options
bindkey -v # vim mode
setopt autocd
unsetopt beep

# Completion
setopt globdots
zstyle ':completion:*' completer _complete _ignored _correct _approximate
fpath+=$ZDOTDIR/completions
autoload -Uz compinit
compinit

# Correction
setopt correct

# History
setopt share_history
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt hist_reduce_blanks
HISTFILE=~/.cache/histfile
HISTSIZE=100000
SAVEHIST=20000

# Prompt (with git)
# Uses the git prompt that comes with git
# Location varies depending on the distro
setopt PROMPT_SUBST
#source /usr/share/git/completion/git-prompt.sh
source /usr/share/git-core/contrib/completion/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=y
GIT_PS1_SHOWSTASHSTATE=y
GIT_PS1_SHOWUNTRACKEDFILES=y
PS1='%F{red}[ %F{yellow}%n %F{green}@ %F{cyan}%3~ %F{blue}]$(__git_ps1 " (%s)")%F{magenta} %(!.#.$) %f'

# History search with Ctrl-R
bindkey "^R" history-incremental-search-backward

# Add aliases
if [[ -r ~/.config/zsh/.aliasrc ]]; then
    source ~/.config/zsh/.aliasrc
fi

# Fish-like autosuggestions
#source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Syntax highlighting (always last)
#source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
