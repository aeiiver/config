#!/bin/sh

# don't actually try to run this script...
echo "NO! DO NOT RUN"
exit

# Arch base system
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

# AUR helper: yay
tmp=_yay
git clone https://aur.archlinux.org/"$AUR_HELPER" "$tmp"
(
	cd "$tmp" || :
	makepkg -si --noconfirm
)
rm -rf "$tmp"

# Userland
pacman -S - <<-EOF
	acpi
	age
	bash-completion
	dos2unix
	expac
	fd
	fzf
	git
	htop
	hyperfine
	lazygit
	lostfiles
	lsof
	man-db
	man-pages
	mpv
	neovim
	nnn
	pacman-contrib
	pacutils
	pkgfile
	reflector
	ripgrep
	rsync
	stow
	trash-cli
	tree
	wget
	xdg-user-dirs
	yt-dlp
EOF

yay -S - <<-EOF
dashbinsh
pfetch
tagutil
EOF

#########################################################

cd_and_stow() (
    cd "$1" || :
    stow "$2"
)

batsignal                   # desktop :hypr

grimblast-git               # desktop :hypr
hyprpicker                  # desktop :hypr

brightnessctl               # desktop :hypr
copyq                       # desktop :hypr
foot                        # desktop :foot :hypr
gammastep                   # desktop :hypr
hyprland                    # desktop :hypr
ksnip                       # desktop :hypr
mako                        # desktop :mako NOTE:notification daemon
pavucontrol                 # desktop :waybar
playerctl                   # desktop :hypr DEP:waybar-hyprland
polkit-gnome                # desktop :hypr NOTE:authentification agent
qt5-wayland                 # desktop NOTE:Qt support
qt5ct                       # desktop :hypr
qt6-wayland                 # desktop NOTE:Qt support
swaybg                      # desktop :hypr
swayidle                    # desktop :hypr
tofi                        # desktop :hypr :tofi
waybar-hyprland-git         # desktop :hypr :waybar
waylock                     # desktop :hypr
wl-clipboard                # desktop NOTE:provide a clipboard
xdg-utils                   # desktop NOTE:provide xdg-open

# Fonts
noto-fonts
noto-fonts-cjk
noto-fonts-emoji
ttf-jetbrains-mono-nerd

# Sound server
pipewire
pipewire-alsa
pipewire-jack
pipewire-pulse
wireplumber

# Look & feel
mint-l-icons
mint-l-theme
xsettingsd
cd_and_stow desktop lookandfeel

# Network system tray icon
network-manager-applet
nm-connection-editor

# XDG desktop portal support
xdg-desktop-portal
xdg-desktop-portal-hyprland
grim
slurp

# Emoji provider
yay -S bemoji
bemoji -D all

# Desktop-aware userland
pacman -S - <<-EOF
	flatpak
	handlr
	imv
	kvantum
	viu
	zathura
	zathura-pdf-mupdf
EOF

yay -S - <<-EOF
dragon-drop
nwg-look
EOF

# Ensure mimeapps.list symlink exists
mkdir -pv "${XDG_DATA_HOME:-$HOME/.local/share}"/applications
ln -sv "${XDG_CONFIG_HOME:-$HOME/.config}"/mimeapps.list "${XDG_DATA_HOME:-$HOME/.local/share}"/applications/mimeapps.list
