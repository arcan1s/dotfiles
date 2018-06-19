# redefine pacman and aurman
pacman() {
  /usr/bin/sudo /usr/bin/pacman $* && echo "$*" | grep -q "S\|R\|U" && rehash
}
aurman() {
  /usr/bin/aurman $* && echo "$*" | grep -q "S\|R\|U" && rehash
}
