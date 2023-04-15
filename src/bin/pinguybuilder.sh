#!/bin/bash
zenity --question --title=BodhiBuilder --text="rootになっていますか？\n有線で接続していますか？\n確認してください。\n続けますか？" --no-wrap
[ "$?" = "0" ] || exit
zenity --question --title=BodhiBuilder --text="ubiquity-frontend-gtk もしくはubiquity-frontend-kde のどちらかひとつをインストールしてありますか？\n確認してください。\n続けますか？" --no-wrap
[ "$?" = "0" ] || exit

if [ ! -z "$(dpkg -l|grep 'ii  grub-efi-amd64 ')" ]; then
  apt-get --purge remove -y --force-yes grub-efi-amd64
fi
if [ ! -z "$(dpkg -l|grep 'ii  grub-efi-amd64-signed')" ]; then
  apt-get --purge remove -y --force-yes grub-efi-amd64-signed shim-signed
fi
apt-get clean
rm /var/cache/debconf/*-old /var/lib/dpkg/*-old -f
rm -f /var/crash/*
rm -f /etc/basix/trace.log
PinguyBuilder clean
PinguyBuilder dist $1

