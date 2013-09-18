# history
HISTFILE=~/.histfile
HISTSIZE=500000
SAVEHIST=500000

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
autoload -U compinit promptinit
compinit
promptinit
zstyle ':completion:*' insert-tab false         # Автокомплит для первого символа
zstyle ':completion:*' max-errors 2  

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

# PROMPT && RPROMPT
if [[ $EUID == 0 ]]; then
# [root@host dir]#
  PROMPT=$'%{\e[1;37m%}[%{\e[1;31m%}%n%{\e[1;37m%}@%{\e[0;31m%}%m %{\e[1;33m%}%1/%{\e[1;37m%}]#%{\e[0m%} '
else
# [user@host dir]$
  PROMPT=$'%{\e[1;37m%}[%{\e[1;32m%}%n%{\e[1;37m%}@%{\e[0;32m%}%m %{\e[1;33m%}%1/%{\e[1;37m%}]$%{\e[0m%} '
fi
precmd () {
  # Battery charge
  function batcharge {
    bat_perc=`acpi | awk {'print $4;'} | sed -e "s/\s//" -e "s/%.*//"`

    if [[ $bat_perc < 15 ]]; then
      col='%{\e[1;31m%}'
    elif [[ $bat_perc < 50 ]]; then
      col='%{\e[1;33m%}'
    else
      col='%{\e[1;32m%}'
    fi

    echo '%{\e[1;37m%}['$col$bat_perc'%{\e[1;37m%}%%]%{\e[0m%}'
  }
 RPROMPT=$'%{\e[1;37m%}[%{\e[1;36m%}%T%{\e[1;37m%}]%{\e[0m%} '$(batcharge)
#   if [[ $EUID == 0 ]] 
#   then
#     PROMPT=$'%{\e[1;37m%}# %{\e[1;31m%}%n %{\e[1;37m%}at %{\e[0;31m%}%m %{\e[1;37m%}in %{\e[1;33m%}%~ %{\e[1;37m%}[%D] [%*] '$(batcharge)$'%{\e[1;37m%} [%?]\n%{\e[1;31m%}# %{\e[0m%}'
#   else
#     PROMPT=$'%{\e[1;37m%}# %{\e[1;32m%}%n %{\e[1;37m%}at %{\e[0;32m%}%m %{\e[1;37m%}in %{\e[1;33m%}%~ %{\e[1;37m%}[%D] [%*] '$(batcharge)$'%{\e[1;37m%} [%?]\n%{\e[1;32m%}$ %{\e[0m%}'
#   fi
}
# right prompt with time
#RPROMPT=$'%{\e[1;37m%}%T, %D%{\e[0m%}'    


## alias
alias grep='grep --colour=auto'
alias top='htop'
alias chrommsu='chromium --proxy-server=cache.msu:3128'
alias chromtor='chromium --proxy-server="socks://localhost:9050" --incognito'
alias chromi2p='chromium --proxy-server="http=127.0.0.1:4444;https=127.0.0.1:4445" --incognito'
alias df='df -kTh'   
alias du='du -ckh'
alias rm='rm -I'
alias yatest='yaourt --config /etc/pactest.conf'
su () {
  checksu=0
  for flags in $*; do
    if [[ $flags == "-" ]]; then
      checksu=1
    fi
  done
  if [[ $checksu == 0 ]]; then
    echo "Use 'su -', Luke"
    /usr/bin/su - $*
  else
    /usr/bin/su $*
  fi
}

alias ls='ls --color=auto'
alias ll='ls --group-directories-first -lh'
alias lr='ls -R'
alias la='ll -A'
alias lx='ll -BX'
alias lz='ll -rS'
alias lt='ll -rt'
alias lm='la | more'

# alias -s
alias -s {avi,mpeg,mpg,mov,m2v,mkv}=mplayer
alias -s {mp3,flac}=qmmp
alias -s {odt,doc,xls,ppt,docx,xlsx,pptx,csv}=libreoffice
alias -s {pdf}=okular
autoload -U pick-web-browser
alias -s {html,htm}=opera

# function to extract archives
# EXAMPLE: unpack file
unpack () {
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
pack () {
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

# function to contorl xrandr
# EXAMPLE: projctl 1024x768
projctl () {
  if [ $1 ] ; then
    if [ $1 = "-h" ]; then
      echo "Usage:   projctl [ off/resolution ]"
      return
    fi

    if [ $1 = "off" ] ; then
      echo "Disable VGA1"
      xrandr --output VGA1 --off --output LVDS1 --mode 1366x768
    else
      echo "Using resolution: $1"
      xrandr --output VGA1 --mode $1 --output LVDS1 --mode $1
    fi
  else
    echo "Using default resolution"
    xrandr --output VGA1 --mode 1366x768 --output LVDS1 --mode 1366x768
  fi
}
 
# sudo alias
if [[ $EUID == 0 ]]; then
  alias fat32mnt='mount -t vfat -o codepage=866,iocharset=utf8,umask=000'
  # MTS 3G modem
  alias mts_3g='eject /dev/sr1 && sleep 5 && wvdial mts3g & disown'
  alias kdm='kdm && exit'
  alias synctime='{ ntpd -qg; hwclock -w; date; }'
else
  alias pacman='sudo pacman'
  alias fat32mnt='sudo mount -t vfat -o codepage=866,iocharset=utf8,umask=000'
  alias umount='sudo umount'
  alias mount='sudo mount'
  alias netctl='sudo netctl'
  # MTS 3G modem
  alias mts_3g='sudo eject /dev/sr1 && sleep 5 && sudo wvdial mts3g & disown'
  alias desktop='sudo systemctl start smbd.service && sudo systemctl start nmbd.service && sudo systemctl start sshd && sudo kdm && exit'
  alias kdm='sudo kdm && exit'
  alias synctime='{ sudo ntpd -qg; sudo hwclock -w; date; }'
  alias wifi-menu='sudo wifi-menu'
  alias dhcpcd='sudo dhcpcd'
  alias journalctl='sudo journalctl'
  alias systemctl='sudo systemctl'
  alias modprobe='sudo modprobe'
  alias rmmod='sudo rmmod'
fi

# global alias
alias -g g="| grep"
alias -g l="| less"
alias -g t="| tail"
alias -g h="| head"
alias -g dn="&> /dev/null &"

# pkgfile
source /usr/share/doc/pkgfile/command-not-found.zsh

# editor
export EDITOR="vim"

# hash
hash -d global=/mnt/global
hash -d windows=/mnt/windows
hash -d iso=/mnt/iso
hash -d u1=/mnt/usbdev1
hash -d u2=/mnt/usbdev2

# umask
umask 022

# path
export PATH="$PATH:$HOME/bin/:/opt/gromacs_old/bin/:$HOME/bin/namd:$HOME/bin/namd_gpu"
