if [[ ${EUID} != 0 ]]; then
  if [[ -e "${HOME}/.ssh/id_rsa" ]]; then
    ssh-add </dev/null 2> /dev/null
  fi
fi
