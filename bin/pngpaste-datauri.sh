#!/bin/sh
F=`mktemp /tmp/psd.XXXX`.png
pngpaste $F
datauri.py $F