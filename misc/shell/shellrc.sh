# shellcheck shell=sh

################################################################################
### Common shell environment

# XDG base directories
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_DATA_HOME="$HOME"/.local/share
export XDG_STATE_HOME="$HOME"/.local/state

# Preferred applications
export EDITOR=nvim
export VISUAL=nvim
export PAGER='less -R'
export MANPAGER='less -R --use-color -Dd+c -Du+y'
export MANROFFOPT='-P -c'

# Aliases
alias v='$VISUAL'
alias ls='command ls --color=auto'
alias la='command ls -lA --color=auto'
alias grep='command grep --color=auto'
alias diff='command diff --color=auto'
alias ip='command ip --color=auto'

# Utility functions
safe_source() {
	# shellcheck disable=1090
	[ -f "$1" ] && [ -r "$1" ] && . "$1"
}
prepend_path() {
	case :"$PATH": in
	*:"$1":*) return ;;
	esac
	PATH=$1:$PATH
}
