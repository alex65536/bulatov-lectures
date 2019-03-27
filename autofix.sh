#!/bin/bash

shopt -s globstar

sedfix() {
	sed -E -i "$1" tex/**/*.tex
}

foldfix() {
	for FILE in tex/**/*.tex; do
		NEWFILE="$(awk -f wrap.awk "$FILE")"
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

# Wrap each line to 80 chars each
foldfix