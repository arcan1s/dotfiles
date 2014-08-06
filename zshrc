# history
HISTFILE=~/.zsh_history
HISTSIZE=500000
SAVEHIST=500000

# highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
# brackets
ZSH_HIGHLIGHT_STYLES[bracket-level-1]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-2]='fg=red,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-3]='fg=yellow,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-4]='fg=magenta,bold'
# cursor
#ZSH_HIGHLIGHT_STYLES[cursor]='bg=blue'
# main
# default
ZSH_HIGHLIGHT_STYLES[default]='none'
# unknown
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red'
# command
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=magenta,bold'
ZSH_HIGHLIGHT_STYLES[alias]='fg=yellow,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[function]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[command]='fg=green'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=green'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=blue,bold'
# path
ZSH_HIGHLIGHT_STYLES[path]='fg=cyan,bold'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[path_approx]='fg=cyan'
# shell
ZSH_HIGHLIGHT_STYLES[globbing]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=blue'
ZSH_HIGHLIGHT_STYLES[assign]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=blue'
# quotes
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=yellow,underline'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=yellow'
# pattern
ZSH_HIGHLIGHT_PATTERNS+=('\~b/rm ' 'fg=green')
# root
#ZSH_HIGHLIGHT_STYLES[root]='bg=red'

# bindkeys
bindkey '^[[A'  up-line-or-search               # up arrow for back-history-search
bindkey '^[[B'  down-line-or-search             # down arrow for fwd-history-search
bindkey '\e[1~' beginning-of-line               # home
bindkey '\e[2~' overwrite-mode                  # insert
bindkey '\e[3~' delete-char                     # del
bindkey '\e[4~' end-of-line                     # end
bindkey '\e[5~' up-line-or-history              # page-up
bindkey '\e[6~' down-line-or-history            # page-down

# autocomplit
autoload -U compinit
compinit
zstyle ':completion:*' insert-tab false         # Автокомплит для первого символа
zstyle ':completion:*' max-errors 2

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
SPROMPT="Correct '%R' to '%r' ? ([Y]es/[N]o/[E]dit/[A]bort) "

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

# PROMPT && RPROMPT
if [[ $EUID == 0 ]]; then
# [root@host dir]#
  PROMPT="%{$fg_bold[white]%}[%{$reset_color%}\
%{$fg_bold[red]%}%n%{$reset_color%}\
%{$fg_bold[white]%}@%{$reset_color%}\
%{$fg_no_bold[red]%}%m %{$reset_color%}\
%{$fg_bold[yellow]%}%1/%{$reset_color%}\
%{$fg_bold[white]%}]# %{$reset_color%}"
else
# [user@host dir]$
  PROMPT="%{$fg_bold[white]%}[%{$reset_color%}\
%{$fg_bold[green]%}%n%{$reset_color%}\
%{$fg_bold[white]%}@%{$reset_color%}\
%{$fg_no_bold[green]%}%m %{$reset_color%}\
%{$fg_bold[yellow]%}%1/%{$reset_color%}\
%{$fg_bold[white]%}]$ %{$reset_color%}"
fi
precmd () {
  # battery charge
  function batcharge {
    bat_perc=`acpi | awk {'print $4;'} | sed -e "s/\s//" -e "s/%.*//"`

    if [[ $bat_perc < 15 ]]; then
      col="%{$fg_bold[red]%}"
    elif [[ $bat_perc < 50 ]]; then
      col="%{$fg_bold[yellow]%}"
    else
      col="%{$fg_bold[green]%}"
    fi

    echo "%{$fg_bold[white]%}["$col$bat_perc"%{$fg_bold[white]%}%%]%{$reset_color%}"
  }
  # last command
  returncode="%(?.%{$fg[green]%}.%{$fg[red]%})%?%{$resetcolor%}"
  RPROMPT="%{$fg_bold[white]%}[%{$reset_color%}\
%{$fg_bold[cyan]%}%T%{$reset_color%}\
%{$fg_bold[white]%}]%{$reset_color%}"\
$(batcharge)\
"%{$fg_bold[white]%}[%{$reset_color%}"\
$returncode\
"%{$fg_bold[white]%}]%{$reset_color%}"
}
# right prompt with time
#RPROMPT=$'%{\e[1;37m%}%T, %D%{\e[0m%}'

show_which() {
  OUTPUT=$(which $1 | cut -d " " -f7-)
  echo "Running '$OUTPUT'" 1>&2
}
## alias
alias grep='grep --colour=auto'
alias top='htop'
alias chrommsu='chromium --proxy-server=cache.msu:3128'
alias chromtor='chromium --proxy-server="socks://localhost:9050" --incognito'
alias chromi2p='chromium --proxy-server="http=127.0.0.1:4444;http=127.0.0.1:4444" --incognito'
alias df='df -k --print-type --human-readable'
alias du='du -k --total --human-readable'
alias less='vimpager'
alias zless='vimpager'
rm() {
  # error check
  [ $# -eq 0 ] && { echo "Files are not set!"; return 1 }
  echo "$@" | grep -qe '-h\|--help' && { echo "Usage: rm FILE..."; return 0 }
  echo "$@" | grep -q "-" && echo "Warning: this function doesn't support any flags"
  # set trash path
  TRASHDIR="$HOME/.local/share/Trash"
  TRASHFILE="${TRASHDIR}/files"
  TRASHINFO="${TRASHDIR}/info"
  for DIRECTORY in "${TRASHDIR}" "${TRASHFILE}" "${TRASHINFO}"; do
    if [ -e "${DIRECTORY}" ]; then
      [ -d "${DIRECTORY}" ] || { echo "'${DIRECTORY}' is a file"; return 1 }
    else
      mkdir -p -m755 "${DIRECTORY}"
    fi
  done
  # confirm
  CONFIRM=""
  echo -n "You realy want to remove '$@'? [y/n] "; read -k1 CONFIRM; echo
  [[ ! $CONFIRM =~ [yY] ]] && return 1
  # move
  for FILE in "$@"; do
    DESTFILE="$(basename -- "${FILE}")"
    SUFFIX='';
    ITER=0;
    while [ -e "${TRASHFILE}/${DESTFILE}${SUFFIX}" ]; do
      SUFFIX="_${ITER}";
      ITER=$(expr ${ITER} + 1)
    done
    echo "Remove '${FILE}'"
    if [ "$(dirname -- "$(realpath -- "${FILE}")")" == "${TRASHFILE}" ]; then
      /usr/bin/rm -rf -- "${FILE}"
      /usr/bin/rm -rf -- "${TRASHINFO}/${DESTFILE}.trashinfo"
    else
      mv -- "${FILE}" "${TRASHFILE}/${DESTFILE}${SUFFIX}" || return 1
      echo "[Trash Info]\nPath=$(realpath -- "${FILE}")\nDeletionDate=$(date +%Y-%m-%dT%H:%M:%S)" > "${TRASHINFO}/${DESTFILE}${SUFFIX}.trashinfo" || return 1
    fi
  done
}
su() {
  CHECKSU=0
  for FLAG in $*; do
    [[ $FLAG == "-" ]] && CHECKSU=1
    [[ $FLAG == "-l" ]] && CHECKSU=1
    [[ $FLAG == "--login" ]] && CHECKSU=1
  done
  if [[ $CHECKSU == 0 ]]; then
    echo "Use 'su -', Luke"
    /usr/bin/su - $*
  else
    /usr/bin/su $*
  fi
}
pacman() {
  /usr/bin/sudo /usr/bin/pacman $* && echo "$*" | grep -q "S\|R\|U" && rehash
}
yaourt() {
  /usr/bin/yaourt $* && echo "$*" | grep -q "S\|R\|U" && rehash
}
yatest() {
  /usr/bin/yaourt --config /etc/pactest.conf $* && echo "$*" | grep -q "S\|R\|U" && rehash
}
yaaur() {
  /usr/bin/yaourt --config /etc/pacaur.conf $* && echo "$*" | grep -q "S\|R\|U" && rehash
}

alias ls='ls --color=auto --group-directories-first'
alias ll='ls -l --human-readable'
alias lr='ls --recursive'
alias la='ll --almost-all'
alias lx='ll -X --ignore-backups'
alias lz='ll -S --reverse'
alias lt='ll -t --reverse'
alias lm='la | more'

# alias -s
alias -s {avi,mpeg,mpg,mov,m2v,mkv}=mpv
alias -s {mp3,flac}=qmmp
alias -s {odt,doc,xls,ppt,docx,xlsx,pptx,csv}=libreoffice
alias -s {pdf}=okular
autoload -U pick-web-browser
alias -s {html,htm}=qupzilla

# function to extract archives
# EXAMPLE: unpack file
unpack() {
  if [[ -f $1 ]]; then
    case $1 in
      *.tar.bz2)   tar xjfv $1                             ;;
      *.tar.gz)    tar xzfv $1                             ;;
      *.tar.xz)    tar xvJf $1                             ;;
      *.bz2)       bunzip2 $1                              ;;
      *.gz)        gunzip $1                               ;;
      *.rar)       unrar x $1                              ;;
      *.tar)       tar xf $1                               ;;
      *.tbz)       tar xjvf $1                             ;;
      *.tbz2)      tar xjf $1                              ;;
      *.tgz)       tar xzf $1                              ;;
      *.zip)       unzip $1                                ;;
      *.Z)         uncompress $1                           ;;
      *.7z)        7z x $1                                 ;;
      *)           echo "I don't know how to extract '$1'" ;;
    esac
  else
    case $1 in
      *help)       echo "Usage: unpack ARCHIVE_NAME"       ;;
      *)           echo "'$1' is not a valid file"         ;;
    esac
  fi
}

# function to create archives
# EXAMPLE: pack tar file
pack() {
  if [ $1 ]; then
    case $1 in
      tar.bz2)     tar -cjvf $2.tar.bz2 $2                 ;;
      tar.gz)      tar -czvf $2.tar.bz2 $2                 ;;
      tar.xz)      tar -cf - $2 | xz -9 -c - > $2.tar.xz   ;;
      bz2)         bzip $2                                 ;;
      gz)          gzip -c -9 -n $2 > $2.gz                ;;
      tar)         tar cpvf $2.tar  $2                     ;;
      tbz)         tar cjvf $2.tar.bz2 $2                  ;;
      tgz)         tar czvf $2.tar.gz  $2                  ;;
      zip)         zip -r $2.zip $2                        ;;
      7z)          7z a $2.7z $2                           ;;
      *help)       echo "Usage: pack TYPE FILES"           ;;
      *)           echo "'$1' cannot be packed via pack()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# functions to contorl xrandr
# EXAMPLE: projctl 1024x768
projctl() {
  MONITORS="$(xrandr | grep connected | cut -d ' ' -f 1 | tr '\n' ' ')"
  echo "Available monitors are: ${MONITORS}"
  FIRSTMON="LVDS1"
  SECONDMON="VGA1"
  RESOLUTION="1366x768"
  until [ -z $1 ]; do
    case "$1" in
      "-h" | "--help"    ) echo "Usage: projctl [ off/resol ] [ -o MON | --output MON ]" && exit 0 ;;
      "-o" | "--output"  ) [ -z "$2" ] || SECONDMON="$2" && shift                                  ;;
      *                  ) RESOLUTION="$1"                                                         ;;
    esac
    shift
  done
  if [[ "${RESOLUTION}" == "off" ]]; then
    echo "Disable ${SECONDMON}"
    xrandr --output ${FIRSTMON} --mode ${RESOLUTION} --output ${SECONDMON} --off
  else
    echo "Using resolution: ${RESOLUTION}"
    xrandr --output ${FIRSTMON} --mode ${RESOLUTION} --output ${SECONDMON} --mode ${RESOLUTION}
  fi
}

twinmon() {
  MONITORS="$(xrandr | grep connected | cut -d ' ' -f 1 | tr '\n' ' ')"
  echo "Available monitors are: ${MONITORS}"
  FIRSTMON="LVDS1"
  SECONDMON="VGA1"
  MODE="on"
  until [ -z $1 ]; do
    case "$1" in
      "-h" | "--help"    ) echo "Usage: twinmon [ off ] [ -o MON | --output MON ]" && exit 0 ;;
      "-o" | "--output"  ) [ -z "$2" ] || SECONDMON="$2" && shift                            ;;
      "off"              ) MODE="off"                                                        ;;
    esac
    shift
  done
  if [[ "${MODE}" == "off" ]]; then
    echo "Disable ${SECONDMON}"
    xrandr --output ${FIRSTMON} --auto --primary --output ${SECONDMON} --off
  else
    echo "Enable ${SECONDMON}"
    xrandr --output ${FIRSTMON} --auto --primary --output ${SECONDMON} --auto --left-of ${FIRSTMON}
  fi
}

# sudo alias
if [[ $EUID == 0 ]]; then
  alias fat32mnt='mount -t vfat -o codepage=866,iocharset=utf8,umask=000'
  # MTS 3G modem
  alias mts_3g='eject /dev/sr1 && sleep 5 && wvdial mts3g && disown'
  alias sddm='systemctl start sddm && exit'
  alias synctime='{ ntpd -qg; hwclock -w; date; }'
else
  alias fat32mnt='sudo mount -t vfat -o codepage=866,iocharset=utf8,umask=000'
  alias umount='sudo umount'
  alias mount='sudo mount'
  alias netctl='sudo netctl'
  # MTS 3G modem
  alias mts_3g='sudo eject /dev/sr1 && sleep 5 && sudo wvdial mts3g && disown'
  alias desktop='sudo systemctl start sshd && sudo systemctl start sddm && exit'
  alias sddm='sudo systemctl start sddm && exit'
  alias synctime='{ sudo ntpd -qg; sudo hwclock -w; date; }'
  alias wifi-menu='sudo wifi-menu'
  alias dhcpcd='sudo dhcpcd'
  alias systemctl='sudo systemctl'
  alias modprobe='sudo modprobe'
  alias rmmod='sudo rmmod'
  alias pacdiff='sudo pacdiff'
  alias staging-i686-build='sudo staging-i686-build'
  alias staging-x86_64-build='sudo staging-x86_64-build'
  alias multilib-staging-build='sudo multilib-staging-build'
  alias backlight='sudo backlight'
  alias cpu='sudo cpu'
  alias svim='sudo vim'
  alias scat='sudo cat'
  alias sgrep='sudo grep'
fi

# global alias
alias -g g="| grep"
alias -g l="| less"
alias -g t="| tail"
alias -g h="| head"
alias -g n="| wc -l"
alias -g dn="&> /dev/null &"

# pkgfile
source /usr/share/doc/pkgfile/command-not-found.zsh

# editor
export EDITOR="vim"
export PAGER="vimpager"

# hash
hash -d global=/mnt/global
hash -d windows=/mnt/windows
hash -d iso=/mnt/iso
hash -d u1=/mnt/usbdev1
hash -d u2=/mnt/usbdev2
# to run command ignoring aliases
hash -d b=/usr/bin

# umask
umask 022

# path
export PATH="$HOME/.local/bin/:$HOME/.local/bin/namd:$HOME/.local/bin/namd_gpu:$PATH"

# color gcc
export GCC_COLOR="auto"

# fix urxvt
if [[ ${TERM} =~ "rxvt-unicode-*" ]] export TERM="xterm"
