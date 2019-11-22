#!/bin/bash

fdisk -l /dev/sdb

echo "[*] Enter Device Name [\dev\sdb1, \dev\sdb2 etc]: "

read usb

echo "[*] Enter Distro Name [parrot, kali, ubuntu etc]: "

read distro

cryptsetup --verbose --verify-passphrase luksFormat $usb

cryptsetup luksOpen $usb $distro

mkfs.ext4 -L persistence /dev/mapper/$distro

e2label /dev/mapper/$distro persistence

mkdir -p /mnt/$distro

mount /dev/mapper/$distro /mnt/$distro

echo "/ union" > /mnt/$distro/persistence.conf

umount /dev/mapper/$distro

cryptsetup luksClose /dev/mapper/$distro

reboot