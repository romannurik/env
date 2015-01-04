#!/usr/bin/env python
import simplejson
import sys


def main():
  o = simplejson.load(sys.stdin)
  simplejson.dump(o, sys.stdout, indent=2, sort_keys=True)


if __name__ == '__main__':
  main()
