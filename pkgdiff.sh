#!/bin/bash

# list explicitly installed packages that are not included in the README
comm -23 \
	<(pacman -Qqe) \
	<(sed '1,/```/d' README.md | sort | sed '1,/```/d')
