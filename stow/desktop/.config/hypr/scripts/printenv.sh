#!/bin/sh

find "$XDG_CONFIG_HOME"/hypr/ -type f -and -name '*.conf' \
    -exec sed -n 's/env *= *\([^,]*\) *, *\(.*\)/export \1="\2"/p' {} +
