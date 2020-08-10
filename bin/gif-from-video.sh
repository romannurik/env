#!/bin/sh
# Pass in the path to the video
ffmpeg -y -i "$1" -vf palettegen __palette.png
ffmpeg -y -i "$1" -lavfi paletteuse "$1.gif"
rm __palette.png
