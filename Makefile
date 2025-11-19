# Makefile pour générer CR.pdf à partir de CR.md

CR.pdf: CR.md
	pandoc CR.md \
	  --pdf-engine=xelatex \
	  --listings \
	  -o CR.pdf

# --- Conversion PPTX -> PDF -> PNG ---------------------------------------

PNG_DENSITY ?= 300
PPTX_FILES := $(wildcard *.pptx)
PPTX_PDFS := $(PPTX_FILES:.pptx=.pdf)
PPTX_STAMPS := $(PPTX_FILES:.pptx=.slides)

.PHONY: slides
slides: $(PPTX_STAMPS)

%.pdf: %.pptx
	libreoffice --headless --convert-to pdf $<
	@test -f $@ || mv $(basename $<).pdf $@

%.slides: %.pdf
	convert -density $(PNG_DENSITY) $< $(basename $<)-%02d.png
	@touch $@


.PHONY: pdf clean clean-slides

pdf: CR.pdf

clean:
	rm -f CR.pdf

clean-slides:
	rm -f $(PPTX_PDFS) $(PPTX_STAMPS)
