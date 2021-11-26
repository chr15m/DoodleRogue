EXTRAS=$(wildcard extras/*)
EXTRAS_PNG=$(foreach E,$(EXTRAS),$(subst .svg,.png,$(E)))
SOURCES=README.pdf tiles.svg tiles-*.png $(EXTRAS) $(EXTRAS_PNG)

DoodleRogue.zip: $(SOURCES)
	zip -r $@ $^

extras/%.png: extras/%.svg
	inkscape $< --export-png=$@

README.pdf: README.md styles.css *.png
	pandoc README.md -o README-pre.html
	echo "<style>" > README.html
	cat styles.css >> README.html
	echo "</style>" >> README.html
	cat README-pre.html >> README.html
	wkhtmltopdf README.html README.pdf
	rm README*.html
