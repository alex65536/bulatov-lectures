.PHONY: build clean distclean

build:
	latexmk -pdf main.tex

clean:
	latexmk -c

distclean: clean
	rm -f main.pdf
