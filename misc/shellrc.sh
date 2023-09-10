# vi: foldmethod=marker

# BASH {{{

HISTSIZE=200000
HISTCONTROL=ignoredups
HISTTIMEFORMAT='%F %T  '
shopt -s histappend
shopt -s hostcomplete
stty -ixon

# end BASH }}}

# ZSH {{{

HISTFILE=~/.zsh_history
HISTSIZE=200000
SAVEHIST=200000
bindkey -e

# }}}

# SH {{{

# XDG base directories
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_DATA_HOME="$HOME"/.local/share
export XDG_STATE_HOME="$HOME"/.local/state

# Environment variables
export EDITOR=nvim
export VISUAL=nvim
export PAGER='less -R --use-color'
export MANPAGER='less -R --use-color -Dd+c -Du+y'
export MANROFFOPT='-P -c'

# Aliases
alias v='command $VISUAL'
alias ls='command ls --color=auto'
alias la='command ls -lA --color=auto'
alias grep='command grep --color=auto'
alias diff='command diff --color=auto'
alias ip='command ip --color=auto'

# Utilities
path_prepend() {
	case :$PATH: in
	*:$1:*) return ;;
	esac
	export PATH="$1:$PATH"
}
source_checked() {
	# shellcheck disable=1090
	[ -f "$1" ] && [ -r "$1" ] && . "$1"
}

# end SH }}}
