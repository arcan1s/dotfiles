# История команд
HISTFILE=~/.histfile
HISTSIZE=50000
SAVEHIST=50000

# Назначения клавиш
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

# Автокомплит
autoload -U compinit promptinit
compinit
promptinit
zstyle ':completion:*' insert-tab false         # Автокомплит для первого символа

# Autocd
setopt autocd

# Correct
setopt CORRECT_ALL
SPROMPT="Correct '%R' to '%r' ? ([Y]es/[N]o/[E]dit/[A]bort)"

# Disable beeps
unsetopt beep

# Автозагрузка калькулятора
autoload zcalc

# Формат приглашения (PROMPT) и часов (RPROMPT)
if [[ $EUID == 0 ]] 
then
 PROMPT=$'%{\e[1;37m%}[%{\e[1;31m%}%n%{\e[1;37m%}@%{\e[1;31m%}%m %{\e[1;33m%}%1/%{\e[1;37m%}]#%{\e[0m%} '   # [root@host dir]#
else
 PROMPT=$'%{\e[1;37m%}[%{\e[1;32m%}%n%{\e[1;37m%}@%{\e[1;32m%}%m %{\e[1;33m%}%1/%{\e[1;37m%}]$%{\e[0m%} '   # [user@host dir]$
fi
RPROMPT=$'%{\e[1;37m%}%T, %D%{\e[0m%}'                                                                      # right prompt with time


## Alias'ы
alias grep='grep --colour=auto'
alias synctime='{ ntpd -qg; hwclock -w; date; }'
alias top='htop'
alias chromtor='chromium --proxy-server="socks://localhost:9050"'
alias chromi2p='chromium --proxy-server="https=127.0.0.1:4445;http=127.0.0.1:4444"'
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

# Alias -s
alias -s {avi,mpeg,mpg,mov,m2v}=mplayer
alias -s {mp3,flac}=amarok
alias -s {odt,doc,xls,ppt,docx,xlsx,pptx,csv}=libreoffice
autoload -U pick-web-browser
alias -s {html,htm}=opera

# EXAMPLE: extract file
ext () {
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

# EXAMPLE: pk tar file
pk () {
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
else
  alias fat32mnt='sudo mount -t vfat -o codepage=866,iocharset=utf8,quiet,umask=000'
  alias umount='sudo umount'
  alias mount='sudo mount'
  alias pacman='sudo pacman'
  alias netcfg='sudo netcfg'
fi

# pkgfile
source /usr/share/doc/pkgfile/command-not-found.zsh

# editor
export EDITOR="vim"
