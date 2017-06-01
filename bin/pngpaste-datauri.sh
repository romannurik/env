#!/bin/sh
# requires pngpaste (brew install pngpaste)
F=`mktemp /tmp/psd.XXXX`.png
pngpaste $F
datauri.py $F
