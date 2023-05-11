#!/bin/bash

comm -23 <(pacman -Qqe) <(sed '1,/```sh/d' README.md | sort | sed '1,/```/d')
