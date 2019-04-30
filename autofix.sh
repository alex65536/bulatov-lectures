#!/bin/bash
set -e

if [ -z "$BASH" ]; then
	echo "Please use Bash for running the script!"
	exit 42
fi

if [ -n "$(git status --porcelain)" ]; then
	echo "Please commit your changes first to prevent loss of data!"
	exit 43
fi

shopt -s globstar

sedfix() {
	sed -E -i "$1" tex/**/*.tex colloquiums/**/*.tex
}

foldfix() {
	for FILE in tex/**/*.tex; do
		NEWFILE="$(gawk -f wrap.awk "$FILE")"
		if [[ "$?" != 0 ]]; then
			echo "wrap.awk failed with non-zero exitcode"
			exit 1
		fi
		echo "$NEWFILE" > "$FILE"
	done
}

# "Т.е.", "т.к", "и т.д." => "т.~е.", "т.~к.", "и т.~д"
sedfix 's/([Тт])(\s*\.\s*|\s*\.\s*~\s*|\s*~\s*\.\s*)([кедп])\.?/\1.~\3./g'

sedfix 's/\\leqslant/\\leq/g'
sedfix 's/\\geqslant/\\geq/g'

sedfix 's/\\R\s*_\s*n/\\R^n/g'

sedfix 's/\.\.\./\\dots/g'

sedfix 's/\\textit/\\emph/g'

sedfix 's/\\Rightarrow|\\Longrightarrow/\\implies/g'
sedfix 's/\\Leftrightarrow|\\Longleftrightarrow/\\iff/g'

sedfix 's/\\int(\s*\\limits\s*_\s*\{?[\\a-zA-Z]+\}?\s*)\\int/\\iint\1/g'

sedfix 's/\\vec\s*\{\s*([a-z])\s*'\''(.*)\}/\\vec \1\\,'\''\2/g'
sedfix 's/\\vec\s*([a-z])\s*'\''/\\vec \1\\,'\''/g'

# Wrap each line to 80 chars each
foldfix
