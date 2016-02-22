# redefine su command
su() {
  local CHECKSU=0
  for FLAG in $*; do
    [[ ${FLAG} == "-" ]] && CHECKSU=1
    [[ ${FLAG} == "-l" ]] && CHECKSU=1
    [[ ${FLAG} == "--login" ]] && CHECKSU=1
  done
  if [[ ${CHECKSU} == 0 ]]; then
    echo "Use 'su -', Luke"
    /bin/su - $*
  else
    /bin/su $*
  fi
}
