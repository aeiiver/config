#!/usr/bin/env sh

# shellcheck disable=2317

# TODO: probably move this into a guided installation script

# don't actually try to run this script...
echo "NO! DO NOT RUN"
exit

# Arch
pacman -S - <<-EOF
	base
	base-devel
EOF

# Firmware
pacman -S - <<-EOF
	alsa-firmware
	intel-ucode
	linux-firmware
	linux-lts
	sof-firmware
EOF

# System utilities
pacman -S - <<-EOF
	efibootmgr
	fwupd
EOF

# Allow wheel users to have great powers
mkdir -p /etc/sudoers.d/
echo "%wheel ALL=(ALL:ALL) ALL" >/etc/sudoers.d/10-wheel

# Networking
pacman -S networkmanager
systemctl enable NetworkManager

# Network time sync
pacman -S chrony
systemctl enable chronyd

# Power saving
pacman -S tlp
systemctl enable vnstat

# CPU Throttling
pacman -S thermald
systemctl enable thermald

# Firewall
pacman -S ufw
systemctl enable ufw

# Restricted access control enforcement
pacman -S apparmor
systemctl enable apparmor
# See https://wiki.archlinux.org/title/AppArmor

# Network usage monitoring
pacman -S vnstat
systemctl enable vnstat

# Network discovery
pacman -S - <<-EOF
	avahi
	nss-mdns
EOF
#TODO

# Printing
pacman -S - <<-EOF
	cups
	cups-pdf
EOF
systemctl enable cups.socket

# OpenDoas
pacman -S opendoas
echo "permit :wheel" >/etc/doas.conf
