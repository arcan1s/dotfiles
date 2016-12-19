## global settings
# history
HISTFILE="${HOME}/.zsh_history"
HISTSIZE=500000
SAVEHIST=500000

# bindkeys
bindkey '^[[A'  up-line-or-search                   # up arrow for back-history-search
bindkey '^[[B'  down-line-or-search                 # down arrow for fwd-history-search
bindkey '\e[1~' beginning-of-line                   # home
bindkey '\e[2~' overwrite-mode                      # insert
bindkey '\e[3~' delete-char                         # del
bindkey '\e[4~' end-of-line                         # end
bindkey '\e[5~' up-line-or-history                  # page-up
bindkey '\e[6~' down-line-or-history                # page-down
# tmux workaround http://superuser.com/questions/403355/how-do-i-get-searching-through-my-command-history-working-with-tmux-and-zshell
bindkey '^R'    history-incremental-search-backward # search for history

# autocomplit
autoload -U compinit
compinit
autoload -U bashcompinit
bashcompinit
# first symbol autocomplete
zstyle ':completion:*' insert-tab false
zstyle ':completion:*' max-errors 2
# correct host complete
[[ -f ${HOME}/.ssh/config ]] && zstyle ':completion:*' hosts $(awk '/^Host .*$/ { print $2 }' "${HOME}/.ssh/config")

# prompt
autoload -U promptinit
promptinit

# colors
autoload -U colors
colors

# autocd
setopt autocd

# correct
setopt CORRECT_ALL
SPROMPT="Correct '%R' to '%r' ? (nyae) "

# append history
setopt APPEND_HISTORY

# ignore dups in history
setopt HIST_IGNORE_ALL_DUPS

# ighore additional space in history
setopt HIST_IGNORE_SPACE

# reduce blanks in history
setopt HIST_REDUCE_BLANKS

# =cmd without autocomplit
unsetopt EQUALS

# disable beeps
unsetopt beep

# autoload calc
autoload zcalc

# automatically log of on 10*60 sec inactivity
export TMOUT=600

## common alias
alias grep='grep --colour=auto'
alias top='htop'
alias df='df -k --print-type --human-readable'
alias du='du -k --total --human-readable'

alias ls='ls --color=auto --group-directories-first'
alias ll='ls -l --human-readable'
alias lr='ls --recursive'
alias la='ll --almost-all'
alias lx='ll -X --ignore-backups'
alias lz='ll -S --reverse'
alias lt='ll -t --reverse'
alias lm='la | more'

# global alias
alias -g _g='| grep'
alias -g _l='| less'
alias -g _t='| tail'
alias -g _h='| head'
alias -g _n='| wc -l'
alias -g _dn='&> /dev/null &'

# to run command ignoring aliases
hash -d b="/bin"

# umask
umask 022

## environment
# editor
export EDITOR="vim"
# color gcc
export GCC_COLOR="auto"
# path
for _DIR in $(find "${HOME}/.local/bin" -type d 2> /dev/null); do export PATH="${_DIR}:${PATH}"; done
# fix urxvt
if [[ ${TERM} =~ "rxvt-unicode-*" ]] export TERM="xterm"
# load valid ssh config
/bin/rm -f "${HOME}/.ssh/config"
find "${HOME}/.ssh/conf.d" -type f -name '*.conf' -exec cat {} > "${HOME}/.ssh/config" \; 2> /dev/null

# load custom settings from $HOME/.zsh
if [[ -a ${HOME}/.zsh-plugins ]]; then
    for _SRC in $(cat "${HOME}/.zsh-plugins"); do source "${HOME}/.zsh/${_SRC}"; done
fi
