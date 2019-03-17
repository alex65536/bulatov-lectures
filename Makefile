.PHONY: build clean distclean

all: style build

build:
	latexmk -pdf -Werror main.tex </dev/null

style:
	bash style.sh

clean:
	latexmk -c

distclean: clean
	rm -f main.pdf main.dvi
