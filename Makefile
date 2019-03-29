.PHONY: build clean distclean style autofix colloc1

LATEXMK = latexmk
LATEXMK_FLAGS =

all: style build

git-revision.out:

build: git-revision.out
	bash git_rev.sh
	$(LATEXMK) -pdf $(LATEXMK_FLAGS) main.tex </dev/null

colloc1:
	cd colloquiums && $(LATEXMK) -pdf $(LATEXMK_FLAGS) colloc1.tex </dev/null

style:
	bash style.sh

autofix:
	bash autofix.sh

clean:
	$(LATEXMK) -c
	cd colloquiums && $(LATEXMK) -c

distclean: clean
	rm -f main.pdf main.dvi
	rm -f git-revision.out
	rm -f colloquiums/colloc*.pdf colloquiums/colloc*.dvi
