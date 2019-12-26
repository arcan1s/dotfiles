# sudo alias
if [[ ${EUID} == 0 ]]; then
  alias fat32mnt='mount -t vfat -o codepage=866,iocharset=utf8,umask=000'
  alias synctime='{ ntpd -qg; hwclock -w; date; }'
else
  alias fat32mnt='sudo mount -t vfat -o codepage=866,iocharset=utf8,umask=000'
  alias modprobe='sudo modprobe'
  alias mount='sudo mount'
  alias pacdiff='sudo pacdiff'
  alias rmmod='sudo rmmod'
  alias scat='sudo cat'
  alias sgrep='sudo grep'
  alias svim='sudo vim'
  alias umount='sudo umount'
fi
