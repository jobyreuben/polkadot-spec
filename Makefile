SOURCES := index.adoc $(wildcard ??_*/*.adoc) $(wildcard ??_*/*/*.adoc)

.PHONY: default html pdf tex clean


default: html


html: polkadot-spec.html

pdf: polkadot-spec.pdf

tex: polkadot-spec.tex

# TODO: Use attribute-missing=warn --failure-level=WARN

polkadot-spec.html: $(SOURCES) docinfo-header.html style.css asciidoctor-pseudocode.rb asciidoctor-mathjax3.rb
	asciidoctor -r ./asciidoctor-pseudocode.rb -r ./asciidoctor-mathjax3.rb -o $@ $<

polkadot-spec.pdf: $(SOURCES) asciidoctor-pseudocode.rb
	asciidoctor-pdf -r asciidoctor-mathematical -r ./asciidoctor-pseudocode.rb -o $@ $<

polkadot-spec.tex: $(SOURCES)
	asciidoctor-latex -o $@ $<


clean:
	rm -rf polkadot-spec.html polkadot-spec.pdf algo-*.svg stem-*.svg
