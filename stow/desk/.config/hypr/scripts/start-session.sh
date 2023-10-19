#!/bin/sh

. "$HOME/.config/hypr/env"

export XDG_CURRENT_DESKTOP=Hyprland
export XDG_CURRENT_SESSION=Hyprland
export XDG_SESSION_DESKTOP=Hyprland
export XDG_SESSION_TYPE=wayland

exec Hyprland
