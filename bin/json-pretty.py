#!/usr/bin/env python
import json
import sys


def main():
  o = json.load(sys.stdin)
  if len(sys.argv) > 1 and sys.argv[1] == '-u':
    json.dump(o, sys.stdout, separators=(',', ':'))
  else:
    json.dump(o, sys.stdout, indent=2, sort_keys=True)


if __name__ == '__main__':
  main()
