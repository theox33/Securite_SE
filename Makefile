# Makefile pour générer CR.pdf à partir de CR.md

CR.pdf: CR.md
	pandoc CR.md \
  --pdf-engine=xelatex \
  --listings \
  -o CR.pdf


.PHONY: pdf clean

pdf: CR.pdf

clean:
	rm -f CR.pdf
