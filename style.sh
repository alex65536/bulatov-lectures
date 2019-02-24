#!/bin/bash
set -e

EXITCODE=0

finish() {
	rm -f err.stamp
	return "$EXITCODE"
}

trap 'finish 2' SIGHUP SIGINT SIGQUIT SIGTERM

error() {
	EXITCODE=1
	echo "------------"
	echo "ERROR: $*"
	echo
	touch err.stamp
}

check() {
	GREP_PARAMS=(--color -C 1 -nEH)
	while :; do
		case "$1" in
			--)
				shift
				break
			;;
			*)
				break
			;;
		esac
	done
	grep "${GREP_PARAMS[@]}" "$2" "$1" && error "$3"
}

check_file() {
	check -- "$1" \
	      '^.{80,}$' \
	      'Some lines exceed 80 characters in length'
	 
	check -- "$1" \
	      '\$\$' \
	      '$$ found, better use \[ \]'
	
	check -- "$1" \
	      '\\Rightarrow'\
	      'Use \implies'
	
	check -- "$1" \
	      '\\Leftrightarrow' \
	      'Use \iff'
	
	check -- "$1" \
	      '\s(\\left)?\([0-9]+\.?[0-9]*(\\right)?\)' \
	      'Seems that you are trying to reference a formula directly, like (1.5).
Use equation and \eqref{}.'
	
	check -- "$1" \
	      '\\textit' \
	      'Better use \emph instead of \textit'
	
	check -- "$1" \
	      '( - *[а-яА-Я])|([а-яА-Я] *- )|([а-яА-Я](\$[^\$]{1,20}\$| |\})*- *$)|( \- *\$)' \
	      'Use ~--- for a dash. Example:
Это~--- тире'
	
	check -- "$1" \
	      '(\\in|\\subset)\s+R' \
	      'Use \R instead of R (if it'\''s set of real numbers)'
}

export -f error
export -f check
export -f check_file

echo Running style checks...
echo

find . -name "*.tex" -exec bash -c 'check_file "$0" "$1"' '{}' "$WORK_DIR" ';'

if [[ -f err.stamp ]]; then
	echo "There were errors"
	EXITCODE=1
else
	echo "OK"
	EXITCODE=0
fi

finish "$EXITCODE"
