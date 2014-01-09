#!/bin/bash

# prepare
echo "[II] PREPARE"
# EDIT IF YOU WANT OTHER SERVER
sed -ni "/yandex/p" /etc/pacman.d/mirrorlist
# COMMENT IN IF YOU USE i686 SYSTEM
echo -e "[multilib]\nInclude = /etc/pacman.d/mirrorlist\n" >> /etc/pacman.conf
echo -e "[archlinuxfr]\nSigLevel = Never\nServer = http://repo.archlinux.fr/\$arch/\n" >> /etc/pacman.conf
pacman -Sy --noconfirm yaourt ix base-devel
(ls /dev/sd[a-z][1-9]; lspci -k; lsusb) | ix
# after this must be 'exit 0'
#exit 0

# EDIT THIS
# username
NEWUSER="user"
# definition block device
for DISK in $(ls /dev/sd[a-z]); do [[ $(ls ${DISK}* | wc -l) > 3 ]] && DEVICE=$DISK; done
# repo packages (pacman -Qenq)
PKGLIST_REPO="pkglist_repo"
# aur packages (pacman -Qemq)
PKGLIST_OTHER="pkglist_other"
# variables
LOCALE="ru_RU.UTF-8 UTF-8"
LOCALECONF="ru_RU.UTF-8"
KEYMAP="ru"
FONT="UniCyr_8x16"
TIMEZONE="Asia/Krasnoyarsk"

# mkfs
echo "[II] CREATING FS"
mkfs.ext4 -L root "${DEVICE}6" || exit 1
mkfs.ext4 -L boot "${DEVICE}1"
mkswap -L swap "${DEVICE}5"
mkfs.ext4 -L home "${DEVICE}7"

# mount & bind
echo "[II] MOUNTING"
swapon "${DEVICE}5"
mount "${DEVICE}6" /mnt
mkdir /mnt/{dev,proc,sys,home,boot}
mkdir -p /mnt/var/{lib/pacman,cache/pacman/pkg/}
mount -o bind /dev /mnt/dev
mount -o bind /proc /mnt/proc
mount -o bind /sys /mnt/sys
mount "${DEVICE}1" /mnt/boot
mount "${DEVICE}7" /mnt/home

# installation
echo "[II] INSTALLATION"
pacman -r /mnt -Sy --cachedir /mnt/var/cache/pacman/pkg/ --noconfirm $(cat "${PKGLIST_REPO}")

# configiration
echo "[II] CONFIGURATION HOSTNAME"
echo "home" >> /mnt/etc/hostname
echo "[II] CONFIGURATION LOCALE"
echo -e "${LOCALE}" >> /mnt/etc/locale.gen
chroot /mnt locale-gen
echo -e "LANG=${LOCALECONF}\nLC_MESSAGES=${LOCALECONF}\nLC_COLLATE=C" >> /mnt/etc/locale.conf
echo -e "KEYMAP=${KEYMAP}\nFONT=${FONT}" >> /mnt/etc/vconsole.conf
chroot /mnt hwclock -w --localtime
ln -sf "/usr/share/zoneinfo/${TIMEZONE}" "/mnt/etc/localtime"
echo "[II] CONFIGURATION PACMAN"
# COMMENT IN IF YOU USE i686 SYSTEM
echo -e "[multilib]\nInclude = /etc/pacman.d/mirrorlist\n" >> /mnt/etc/pacman.conf
echo -e "[archlinuxfr]\nSigLevel = Never\nServer = http://repo.archlinux.fr/\$arch/\n" >> /mnt/etc/pacman.conf
# EDIT IF YOU WANT OTHER SERVER
echo 'Server = http://mirror.yandex.ru/archlinux/$repo/os/$arch' >> /mnt/etc/pacman.d/mirrorlist
chroot /mnt pacman-key --init
chroot /mnt pacman-key --populate archlinux
echo "[II] INSTALL FROM AUR"
cp "${PKGLIST_OTHER}" /mnt/root/
chroot /mnt bash -c "eval \"dhcpcd && yaourt -S --noconfirm $(cat "/mnt/root/${PKGLIST_OTHER}")\""
echo "[II] CREATING USER"
chroot /mnt useradd -d /home/${NEWUSER} -g users -G audio,video,wheel,lp,storage -m -s /usr/bin/zsh ${NEWUSER}
echo "${NEWUSER} ALL=(ALL) ALL" >> /mnt/etc/sudoers
# DO NOT FORGET ADD THE PASSWORD
echo "[II] CREATING FSTAB"
genfstab -U /mnt >> /mnt/etc/fstab
echo "[II] GENERATE IMAGE AND INSTAL GRUB"
# DO NOW FORGET EDIT MODULES
sed -i 's/MODULES=""/MODULES="i915"/g' /mnt/etc/mkinitcpio.conf
sed -i 's/#COMPRESSION="xz"/COMPRESSION="xz"/g' /mnt/etc/mkinitcpio.conf
chroot /mnt mkinitcpio -p linux
echo "GRUB_DISABLE_SUBMENU=y" >> /mnt/etc/default/grub
chroot /mnt grub-install "${DEVICE}"
chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg
# COMMENT IN IF YOU DON'T USE KDM
echo "[II] ADD KDM TO AUTOLOAD"
chroot /mnt systemctl enable kdm.service
# COMMENT IN IF YOU DON'T USE CUPS
echo "[II] ADD CUPS TO AUTOLOAD"
chroot /mnt systemctl enable cups.service
# COMMENT IN IF YOU DON'T USE BLUETOOTH
echo "[II] ADD BLUETOOTH TO AUTOLOAD"
chroot /mnt systemctl enable bluetooth.service
for PROFILE in $(ls /etc/netctl); do
  if [ ! -d "/etc/netctl/$PROFILE" ]; then
    cp "/etc/netctl/$PROFILE" "/mnt/etc/netctl/$PROFILE"
    echo "[II] ADD NETCTL@$PROFILE TO AUTOLOAD"
    chroot /mnt systemctl enable netctl@$PROFILE.service
  fi
done
echo ".: INSTALLATION COMPLETED :."
