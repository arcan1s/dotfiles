# redefine pacman and aurman
pacman() {
  /usr/bin/sudo /usr/bin/pacman $* && echo "$*" | grep -q "S\|R\|U" && rehash
}
yay() {
  /usr/bin/yay $* && echo "$*" | grep -q "S\|R\|U" && rehash
}
