#!/bin/bash
set -e

EXITCODE=0

finish() {
	rm -f err.stamp
	return "$EXITCODE"
}

trap 'finish 2' SIGHUP SIGINT SIGQUIT SIGTERM

error() {
	local EXITCODE=1
	echo "------------"
	echo "ERROR: $*"
	echo
	touch err.stamp
}

check() {
	local GREP_PARAMS=(--color -C 1 -nH)
	local GREP_MODE=-E
	while :; do
		case "$1" in
			--)
				shift
				break
			;;
			-P)
				GREP_MODE=-P
				shift
			;;
			*)
				break
			;;
		esac
	done
	grep "${GREP_MODE}" "${GREP_PARAMS[@]}" -- "$2" "$1" && error "$3"
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
	      '([^a-zA-Z]\s|$\s)\$?(\\left)?\( *[0-9]+\.?[0-9]* *(\\right)?\) ?\$?' \
	      'Seems that you are trying to reference a formula directly, like (1.5).
Use equation and \eqref{}.'
	
	check -- "$1" \
	      '\\textit' \
	      'Better use \emph instead of \textit'
	
	check -- "$1" \
	      '( - *[а-яА-Я])|([а-яА-Я] *- )|([а-яА-Я](\$[^\$]{1,20}\$| |\})*- *$)|( \- *\$)' \
	      'Use ~--- for a dash. Example:
Это~--- тире'
	
	check -P -- "$1" \
	      '(\\in|\\subset)\s+R(?!\s*\\left\s*\(|\s*\()' \
	      'Use \R instead of R (if it'\''s set of real numbers)'
	
	check -- "$1" \
	      '\\[lg]eqslant' \
	      'You don'\''t need it, because \leq and \geq are redefined as \leqslant and \geqslant in matanhelper'
	
	check -- "$1" \
	      '\.\.\.' \
	      'Use \dots (or \ldots)'
	
	check -- "$1" \
	      '\\int\s*\\int' \
	      'Use \iint for double integral, \iiint for triple integral'
	
}

export -f error
export -f check
export -f check_file

echo Running style checks...
echo

find . -name "*.tex" ! -path "./original-src/*" -exec bash -c 'check_file "$0" "$1"' '{}' "$WORK_DIR" ';'

if [[ -f err.stamp ]]; then
	echo "There were errors"
	EXITCODE=1
else
	echo "OK"
	EXITCODE=0
fi

finish "$EXITCODE"
