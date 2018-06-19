# pacman commands with repo variations
aurtest() {
  /usr/bin/aurman --config /etc/pactest.conf $* && echo "$*" | grep -q "S\|R\|U" && rehash
}
auraur() {
  /usr/bin/aurman --config /etc/pacaur.conf $* && echo "$*" | grep -q "S\|R\|U" && rehash
}
