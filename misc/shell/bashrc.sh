# shellcheck shell=bash

################################################################################
### Bash (~/.bashrc)

# Shell prompt
_generate_ps1() {
	printf '%s' '\['
	tput bold
	tput setaf "$(shuf -i 1-15 -n 1)"
	printf '%s' '\]'
	printf '%s' '\W \$ '
	printf '%s' '\['
	tput sgr0
	printf '%s' '\]'
}
roll_ps1() {
	PS1=$(_generate_ps1)
}
roll_ps1

# Bash-related settings
export HISTSIZE=200000
export HISTCONTROL=ignoredups
export HISTTIMEFORMAT="%F %T  "
shopt -s histappend
shopt -s hostcomplete
stty -ixon

# OSC escape codes
_osc7_cwd() {
	local strlen=${#PWD}
	local encoded=""
	local pos c o
	for ((pos = 0; pos < strlen; pos++)); do
		c=${PWD:$pos:1}
		case "$c" in
		[-/:_.!\'\(\)~[:alnum:]]) o="${c}" ;;
		*) printf -v o '%%%02X' "'${c}" ;;
		esac
		encoded+="${o}"
	done
	# shellcheck disable=1003
	printf '\e]7;file://%s%s\e\\' "${HOSTNAME}" "${encoded}"
}
PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }_osc7_cwd

_osc133_prompt_marker() {
	# shellcheck disable=1003
	printf '\e]133;A\e\\'
}
PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }_osc133_prompt_marker
