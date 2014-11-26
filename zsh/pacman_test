# pacman commands with repo variations
yatest() {
  /usr/bin/yaourt --config /etc/pactest.conf $* && echo "$*" | grep -q "S\|R\|U" && rehash
}
yaaur() {
  /usr/bin/yaourt --config /etc/pacaur.conf $* && echo "$*" | grep -q "S\|R\|U" && rehash
}
