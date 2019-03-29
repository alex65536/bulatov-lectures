#!/bin/bash

echo "Этот скрипт делает конспект более интересным для чтения."
echo "Но он сильно меняет исходники."
echo "НЕ КОММИТЬТЕ после применения этого скрипта к репозиторию!"

while :; do
	echo -n "Продолжить? [Y/N] "
	read -r OUTCOME
	case "$OUTCOME" in
		Y|y|Д|д)
			break
		;;
		N|n|Н|н)
			echo "Останов."
			exit 0
		;;
	esac
done

shopt -s globstar

sed -i -E 's/% add new headers if necessary/\\textit{Конспект был улучшен с применением} \\texttt{antibulatov.sh}./g' tex/title.tex

sed -i -E 's/([Уу])быв/\1бив/g' **/*.tex
sed -i -E 's/конечн/кончен/g' **/*.tex
sed -i -E 's/ескончен/есконечн/g' **/*.tex
sed -i -E 's/([Фф])ункци/\1укнци/g' **/*.tex
sed -i -E 's/([Дд])ифференц/\1езинфиц/g' **/*.tex
sed -i -E 's/([Чч])астн/\1аст/g' **/*.tex 
sed -i -E 's/([Пп])риращ/\1ревращ/g' **/*.tex
sed -i -E 's/предел/беспредел/g' **/*.tex
sed -i -E 's/Предел/Беспредел/g' **/*.tex
sed -i -E 's/([Оо])беспредел/\1предел/g' **/*.tex
sed -i -E 's/([Бб])[Бб]*есбеспредел/\1еспредел/g' **/*.tex
sed -i -E 's/([Сс])меша[н]+/\1мешн/g' **/*.tex
sed -i -E 's/([Пп])роизводн/\1роизводственн/g' **/*.tex
sed -i -E 's/([Яя])вн/\1вственн/g' **/*.tex

echo "Building PDF..."
make build
make clean
