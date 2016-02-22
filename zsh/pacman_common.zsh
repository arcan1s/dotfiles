# redefine pacman and yaourt
pacman() {
  /usr/bin/sudo /usr/bin/pacman $* && echo "$*" | grep -q "S\|R\|U" && rehash
}
yaourt() {
  /usr/bin/yaourt $* && echo "$*" | grep -q "S\|R\|U" && rehash
}
