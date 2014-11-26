# sudo alias
if [[ ${EUID} == 0 ]]; then
  alias mts_3g='eject /dev/sr1 && sleep 5 && wvdial mts3g && disown'
  alias sddm='systemctl start sddm && exit'
else
  alias cpu='sudo cpu'
  alias backlight='sudo backlight'
  alias exante='sudo netctl start exante && sudo systemctl start exante-vpn && sddm'
  alias mts_3g='sudo eject /dev/sr1 && sleep 5 && sudo wvdial mts3g && disown'
  alias sddm='sudo systemctl start sddm && exit'
  alias wifi-menu='sudo wifi-menu'
fi
