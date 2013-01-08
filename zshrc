# history
HISTFILE=~/.histfile
HISTSIZE=500000
SAVEHIST=500000

# bindkeys
bindkey '^[[A' up-line-or-search                # up arrow for back-history-search
bindkey '^[[B' down-line-or-search              # down arrow for fwd-history-search
bindkey ';5D' backward-word                     # ctrl+left 
bindkey ';5C' forward-word                      # ctrl+right
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
if [[ $EUID == 0 ]] 
then
# [root@host dir]#
 PROMPT=$'%{\e[1;37m%}[%{\e[1;31m%}%n%{\e[1;37m%}@%{\e[1;31m%}%m %{\e[1;33m%}%1/%{\e[1;37m%}]#%{\e[0m%} '
else
# [user@host dir]$
 PROMPT=$'%{\e[1;37m%}[%{\e[1;32m%}%n%{\e[1;37m%}@%{\e[1;32m%}%m %{\e[1;33m%}%1/%{\e[1;37m%}]$%{\e[0m%} '
fi
# right prompt with time
RPROMPT=$'%{\e[1;37m%}%T, %D%{\e[0m%}'    


## alias
alias grep='grep --colour=auto'
alias synctime='{ ntpd -qg; hwclock -w; date; }'
alias top='htop'
alias chrommsu='chromium --proxy-server=cache.msu:3128'
alias chromtor='chromium --proxy-server="socks://localhost:9050" --incognito'
alias chromi2p='chromium --proxy-server="http=http://127.0.0.1:4444;https=https://127.0.0.1:4445" --incognito'
alias df='df -h'   
alias du='du -c -h'
alias kdm='kdm && exit'
alias su='su -'

alias ls='ls --color=auto'
alias ll='ls --group-directories-first -l'
alias lr='ls -R'
alias la='ll -A'
alias lx='ll -BX'
alias lz='ll -rS'
alias lt='ll -rt'
alias lm='la | more'

# alias -s
alias -s {avi,mpeg,mpg,mov,m2v}=mplayer
alias -s {mp3,flac}=amarok
alias -s {odt,doc,xls,ppt,docx,xlsx,pptx,csv}=libreoffice
autoload -U pick-web-browser
alias -s {html,htm}=opera

# function for extract archives
# EXAMPLE: unpack file
unpack () {
 if [ -f $1 ] ; then
 case $1 in
   *.tar.bz2)   tar xjf $1        ;;
   *.tar.gz)    tar xzf $1     ;;
   *.bz2)       bunzip2 $1       ;;
   *.rar)       unrar x $1     ;;
   *.gz)        gunzip $1     ;;
   *.tar)       tar xf $1        ;;
   *.tbz2)      tar xjf $1      ;;
   *.tbz)       tar -xjvf $1    ;;
   *.tgz)       tar xzf $1       ;;
   *.zip)       unzip $1     ;;
   *.Z)         uncompress $1  ;;
   *.7z)        7z x $1    ;;
   *)           echo "I don't know how to extract '$1'..." ;;
 esac
 else
   echo "'$1' is not a valid file"
 fi
 }

# function for create archives
# EXAMPLE: pack tar file
pack () {
 if [ $1 ] ; then
 case $1 in
   tbz)       tar cjvf $2.tar.bz2 $2      ;;
   tgz)       tar czvf $2.tar.gz  $2       ;;
   tar)      tar cpvf $2.tar  $2       ;;
   bz2)    bzip $2 ;;
   gz)        gzip -c -9 -n $2 > $2.gz ;;
   zip)       zip -r $2.zip $2   ;;
   7z)        7z a $2.7z $2    ;;
   *)         echo "'$1' cannot be packed via pk()" ;;
 esac
 else
   echo "'$1' is not a valid file"
 fi
}  
 
# sudo alias
if [[ $EUID == 0 ]]
then
  alias fat32mnt='mount -t vfat -o codepage=866,iocharset=utf8,quiet,umask=000'
  # MTS 3G modem
  alias mts_3g='eject /dev/sr1 && sleep 5 && wvdial mts3g & disown'
else
  alias fat32mnt='sudo mount -t vfat -o codepage=866,iocharset=utf8,quiet,umask=000'
  alias umount='sudo umount'
  alias mount='sudo mount'
  alias pacman='sudo pacman'
  alias netcfg='sudo netcfg'
  # MTS 3G modem
  alias mts_3g='sudo eject /dev/sr1 && sleep 5 && sudo wvdial mts3g & disown'
  alias desktop='sudo netcfg-menu && sudo kdm && exit'
fi

# global alias
alias -g g="| grep"
alias -g l="| less"

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
umask 027

# path
export PATH="$PATH:$HOME/bin/"
