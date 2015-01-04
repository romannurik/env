#!/bin/bash
if [[ "$1" == "" ]]; then
  echo Please provide a path >&2
  exit
fi

find $1 -type f -exec svn propdel svn:mime-type {} \;
