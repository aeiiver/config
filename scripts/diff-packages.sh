#!/bin/bash

comm -3 \
	<(pacman -Qqe) \
	<(sort pkglist* | sed 's/\s*#.*//; /^$/d')
