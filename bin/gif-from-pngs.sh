#!/bin/sh
ffmpeg -i "$1" -vf palettegen __palette.png
ffmpeg -i "$1" -i __palette.png -lavfi paletteuse "$1.gif"
rm __palette.png
