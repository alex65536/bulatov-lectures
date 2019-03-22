.PHONY: build clean distclean

LATEXMK = latexmk
LATEXMK_FLAGS =

all: style build

build: git-revision.out
	bash git_rev.sh
	$(LATEXMK) -pdf $(LATEXMK_FLAGS) main.tex </dev/null

style:
	bash style.sh

clean:
	$(LATEXMK) -c

distclean: clean
	rm -f main.pdf main.dvi
