#!/bin/sh

sed -n 's/env *= *\([^,]*\) *, *\(.*\)/export \1="\2"/p' "$(dirname "$0")"/../hyprland.conf
