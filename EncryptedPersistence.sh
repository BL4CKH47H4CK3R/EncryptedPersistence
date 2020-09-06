#!/bin/bash

echo
echo
echo
echo "                     +::::::::::::::::::::::::::::::::::::::::::::::::::+ "
echo "                     +               EncryptedPersistence               + "
echo "                     +::::::::::::::::::::::::::::::::::::::::::::::::::+ "
echo "                     +      Encrypted Persistence For Linux Distro      + "
echo "                     +::::::::::::::::::::::::::::::::::::::::::::::::::+ "
echo "                     +             Creator : BL4CKH47H4CK3R             + "
echo "                     +::::::::::::::::::::::::::::::::::::::::::::::::::+ "
echo
echo

fdisk -l | grep /dev
echo
read -p "[*] Enter Device Name (e.g. \dev\sdb1, \dev\sdb2): " dev
read -p "[*] Enter Distro Name (e.g. arch, debian, kali): " distro
echo
cryptsetup --verbose --verify-passphrase luksFormat $dev
cryptsetup luksOpen $usb $distro
mkfs.btrfs -L persistence -f /dev/mapper/$distro
e2label /dev/mapper/$distro persistence
mkdir -p /mnt/$distro
mount /dev/mapper/$distro /mnt/$distro
echo "/ union" > /mnt/$distro/persistence.conf
umount /dev/mapper/$distro
cryptsetup luksClose /dev/mapper/$distro
reboot
