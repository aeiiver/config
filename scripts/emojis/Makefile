OUT_DIR := out
CACHE_DIR := $(OUT_DIR)/cache

OUT := $(OUT_DIR)/emojis.txt
EMOJILIB_DATA := $(CACHE_DIR)/emojilib.json
UNICODE_DATA := $(CACHE_DIR)/unicode.txt

EMOJILIB_URL := https://unpkg.com/emojilib@3.0.10/dist/emoji-en-US.json
UNICODE_URL := https://unicode.org/Public/emoji/15.0/emoji-test.txt

default: build

build: $(OUT)

clean:
	rm $(OUT)

cleanall:
	rm -r $(OUT_DIR)

.PHONY: default build clean cleanall

$(OUT): $(EMOJILIB_DATA) $(UNICODE_DATA)
	mkdir -p $(OUT_DIR)
	python3 ./generate.py $(OUT) $(EMOJILIB_DATA) $(UNICODE_DATA)

$(EMOJILIB_DATA):
	mkdir -p $(CACHE_DIR)
	curl -Lso $(EMOJILIB_DATA) $(EMOJILIB_URL)

$(UNICODE_DATA):
	mkdir -p $(CACHE_DIR)
	curl -Lso $(UNICODE_DATA) $(UNICODE_URL)
