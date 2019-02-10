.PHONY: build clean distclean

build:
	latexmk -pdf main.tex </dev/null

clean:
	latexmk -c

distclean: clean
	rm -f main.pdf
