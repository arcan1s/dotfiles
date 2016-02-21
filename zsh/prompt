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
precmd() {
  # battery charge
  function batcharge {
    local _bat_perc=0
    local _num=0
    local _bat
    for _bat in /sys/class/power_supply/BAT*; do
      let "_bat_perc += $(cat ${_bat}/capacity)"
      let "_num += 1"
    done
    _bat_perc=$((${_bat_perc}/${_num}))
    local _col
    if [[ ${_bat_perc} < 15 ]]; then
      _col="%{$fg_bold[red]%}"
    elif [[ ${_bat_perc} < 50 ]]; then
      _col="%{$fg_bold[yellow]%}"
    else
      _col="%{$fg_bold[green]%}"
    fi
    echo "%{$fg_bold[white]%}["${_col}${_bat_perc}"%{$fg_bold[white]%}%%]%{$reset_color%}"
  }
  # last command
  returncode="%(?.%{$fg[green]%}.%{$fg[red]%})%?%{$resetcolor%}"
  RPROMPT="%{$fg_bold[white]%}[%{$reset_color%}\
%{$fg_bold[cyan]%}%T%{$reset_color%}\
%{$fg_bold[white]%}]%{$reset_color%}"\
$(batcharge)\
"%{$fg_bold[white]%}[%{$reset_color%}"\
${returncode}\
"%{$fg_bold[white]%}]%{$reset_color%}"
}
