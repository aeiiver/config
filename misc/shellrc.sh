# vi: foldmethod=marker

case "$SHELL" in
*/bash)
	HISTSIZE=200000
	HISTCONTROL=ignoredups
	HISTTIMEFORMAT='%F %T  '
	shopt -s histappend
	shopt -s hostcomplete
	stty -ixon
	;;
*/zsh)
	HISTSIZE=200000
	SAVEHIST=200000
	HISTFILE=~/.zsh_history
	bindkey -e
	;;
esac

### XDG base directories
#
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_DATA_HOME="$HOME"/.local/share
export XDG_STATE_HOME="$HOME"/.local/state

### Preferred applications
#
export EDITOR=nvim
export VISUAL=nvim
export PAGER='less -R --use-color'
export MANPAGER='less -R --use-color -Dd+c -Du+y'
export MANROFFOPT='-P -c'

### Aliases
#
alias v='command $VISUAL'
alias ls='command ls --color=auto'
alias la='command ls -lA --color=auto'
alias grep='command grep --color=auto'
alias diff='command diff --color=auto'
alias ip='command ip --color=auto'

### Utilities
#
path_prepend() {
	if [ ! -d "$1" ] || [ ! -r "$1" ]; then
		echo "path_prepend: '$1' can't be read"
		return 1
	fi
	case :$PATH: in
	*:$1:*) return ;;
	esac
	export PATH="$1:$PATH"
}

path_append() {
	if [ ! -d "$1" ] || [ ! -r "$1" ]; then
		echo "path_append: '$1' can't be read"
		return 1
	fi
	case :$PATH: in
	*:$1:*) return ;;
	esac
	export PATH="$PATH:$1"
}

source_checked() {
	# shellcheck disable=1090
	[ -f "$1" ] && [ -r "$1" ] && . "$1"
}
