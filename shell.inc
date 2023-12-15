### XDG base directories
#
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

### Preferred applications
#
for ed in nvim vim vi nano; do
	if command -v $ed 1>/dev/null 2>&1; then
		export EDITOR=$ed
		break
	fi
done
[ -z "$EDITOR" ] && echo "shell.inc: WARNING: couldn't set EDITOR"
export VISUAL="$EDITOR"
export PAGER='less -R --use-color'
export MANPAGER='less -R --use-color -Dd+c -Du+y'

### Aliases
#
alias v='command $VISUAL'
alias ls='command ls --color=auto'
alias la='command ls -lA --color=auto'
alias grep='command grep --color=auto'
alias diff='command diff --color=auto'
alias ip='command ip --color=auto'

### Shell-specific
#
case "$SHELL" in
*/bash)
	HISTSIZE=4269
	HISTFILESIZE=42690
	HISTCONTROL=ignoredups
	HISTTIMEFORMAT='%F %T  '
	shopt -s histappend
	shopt -s checkwinsize
	stty -ixon
	;;
*/zsh)
	HISTSIZE=4269
	SAVEHIST=42690
	HISTFILE=~/.zsh_history
	bindkey -e
	;;
esac

# vi: ft=sh
