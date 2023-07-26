#!/bin/sh

exec waylock \
	-init-color 0x040000 \
	-input-color 0x080808 \
	-fail-color 0x201010 \
	-fork-on-lock
