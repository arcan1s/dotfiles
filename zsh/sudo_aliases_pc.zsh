# sudo alias
if [[ ${EUID} == 0 ]]; then
  # do nothing yet
else
  alias wifi-menu='sudo wifi-menu'
fi
