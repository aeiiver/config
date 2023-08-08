OUT_DIR := out
CACHE_DIR := $(OUT_DIR)/cache

OUT := $(OUT_DIR)/glyphs.txt
GLYPH_DATA := $(CACHE_DIR)/glyphnames.json
GLYPH_URL := https://raw.githubusercontent.com/ryanoasis/nerd-fonts/v3.0.2/glyphnames.json

default: build

build: $(OUT)

clean:
	rm $(OUT)

cleanall:
	rm -r $(OUT_DIR)

.PHONY: default build clean cleanall

$(OUT): $(GLYPH_DATA)
	mkdir -p $(OUT_DIR)
	jq -r 'del(.METADATA) | to_entries[] | @text "\(.value.char) nf-\(.key)"' $(GLYPH_DATA) >$(OUT)

$(GLYPH_DATA):
	mkdir -p $(CACHE_DIR)
	curl -Lso $(GLYPH_DATA) $(GLYPH_URL)
