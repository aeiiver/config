import json
import re
import sys

# This script will insert emojilib keywords to the Unicode emoji list if applicable.

PROGNAME, OUT_FILE, EMOJILIB_DATA, UNICODE_DATA = sys.argv
VARIANT_SELECTOR = 0xFE0F

"""
muan/emojilib's emoji list is a JSON object with emojis as keys and arrays of
keywords as value:

{
  "😀": [
    "grinning_face",
    "face",
    "smile",
    "happy",
    "joy",
    ":D",
    "grin"
  ],
  ...
}

See more info at: https://github.com/muan/emojilib
"""
with open(EMOJILIB_DATA) as f:
    emojilib: dict[str, str] = json.load(f)
    for emoji in emojilib:
        emojilib[emoji] = ' '.join(emojilib[emoji])

"""
unicode.org's emoji list is a plain text file annoted with emojis. We're only
looking for the fully-qualified emojis:

1F600                                                  ; fully-qualified     # 😀 E1.0 grinning face

See more info at: https://unicode.org/reports/tr51/
"""
with open(UNICODE_DATA) as f:
    output = [
        re.sub('.*# (.*)', r'\1', line)
        for line in f.readlines()
        if re.search('; fully-qualified', line)
    ]

for emoji, keywords in emojilib.items():
    print(f'Processing {emoji}... ', end='')

    emoji = emoji.replace(chr(VARIANT_SELECTOR), '')
    occurences = 0
    for i in range(len(output)):
        for char in emoji:
            output_emoji = output[i].split(' ', 1)[0]
            if char not in output_emoji:
                break

        changed = re.sub(
            f'^([^ ]*{re.escape(emoji)}[^ ]*)',
            rf'\1 {keywords}',
            output[i],
        )
        if changed != output[i]:
            output[i] = changed
            occurences += 1

    print(f'{occurences} occurences replaced.')

with open(OUT_FILE, mode='w') as f:
    f.write(''.join(output))
