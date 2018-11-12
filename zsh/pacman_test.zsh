# pacman commands with repo variations
yaytest() {
  /usr/bin/yay --config /etc/pactest.conf $* && echo "$*" | grep -q "S\|R\|U" && rehash
}
yayaur() {
  /usr/bin/yay --config /etc/pacaur.conf $* && echo "$*" | grep -q "S\|R\|U" && rehash
}
