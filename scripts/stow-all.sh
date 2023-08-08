#!/bin/sh

cmd='stow -v'
[ "$1" = '-D' ] && cmd='stow -Dv'

(
	cd app || return
	# shellcheck disable=2035
	$cmd *
)

(
	cd desktop || return
	# shellcheck disable=2035
	$cmd *
)
