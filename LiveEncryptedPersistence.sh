#!/bin/bash

echo
echo
echo
echo "                     +::::::::::::::::::::::::::::::::::::::::::::::::::+ "
echo "                     +             LiveEncryptedPersistence             + "
echo "                     +::::::::::::::::::::::::::::::::::::::::::::::::::+ "
echo "                     +     Live Encrypted Persistence For USB Device    + "
echo "                     +::::::::::::::::::::::::::::::::::::::::::::::::::+ "
echo "                     +             Creator : BL4CKH47H4CK3R             + "
echo "                     +::::::::::::::::::::::::::::::::::::::::::::::::::+ "
echo
echo

fdisk -l /dev/sdb
read -p "[*] Enter Device Name (e.g. \dev\sdb1, \dev\sdb2): " dev
read -p "[*] Enter Distro Name (e.g. kali, parrot, ubuntu): " distro
cryptsetup --verbose --verify-passphrase luksFormat $dev
cryptsetup luksOpen $usb $distro
mkfs.ext4 -L persistence /dev/mapper/$distro
e2label /dev/mapper/$distro persistence
mkdir -p /mnt/$distro
mount /dev/mapper/$distro /mnt/$distro
echo "/ union" > /mnt/$distro/persistence.conf
umount /dev/mapper/$distro
cryptsetup luksClose /dev/mapper/$distro
reboot
