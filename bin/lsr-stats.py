#!/usr/bin/env python
import sys
import re
import os.path


SUFFIXES = ['KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB']

# http://diveintopython3.org/your-first-python-program.html
def approximate_size(size):
    if size < 0:
        raise ValueError('number must be non-negative')

    multiple = 1024
    for suffix in SUFFIXES:
        size /= multiple
        if size < multiple:
            return '%.f %s' % (size, suffix)

    raise ValueError('number too large')


def _ancestor_folders(folder):
  t = folder.split('/')
  return ['/'.join(t[:n+1]) or '/' for n in range(len(t) - 1)]


def main():
  folder_stats = {}

  # read ls -r output
  common_prefix = ''
  anc_folders = []
  cur_folder = ''
  for line in sys.stdin:
    line = line.strip()
    if line == '':
      cur_folder = ''
    elif cur_folder == '':
      if line[-1] != ':':
        print >> sys.stderr, 'Unexpected line: ' + line
        raise SystemExit
      cur_folder = line[:-1]
      anc_folders = _ancestor_folders(cur_folder)
      common_prefix = os.path.commonprefix([cur_folder, common_prefix]) if common_prefix else cur_folder
    else:
      diff_stats = [0, 0, 0]   # dirs, files, bytes
      if line[0] not in ['-', 'd', 's', 'l', 'c', 'b']:
        print >> sys.stderr, 'Unexpected line: ' + line
        raise SystemExit
      if line[0] == 'd':
        diff_stats[0] += 1
      if line[0] == '-':
        diff_stats[1] += 1
        diff_stats[2] += int(re.split(r'\s+', line)[3])

      for folder in anc_folders + [cur_folder]:
        folder_stats[folder] = map(
            lambda x, y: x + y,
            folder_stats[folder] if folder in folder_stats else [0, 0, 0],
            diff_stats)
  
  # print stats
  st = sorted(
      folder_stats.items(),
      lambda x, y: cmp(x[1][2], y[1][2]))
  for folder_data in st:
    if len(folder_data[0]) < len(common_prefix):
      continue
    print '%7s : %s' % (approximate_size(folder_data[1][2]), folder_data[0])

if __name__ == '__main__':
  main()