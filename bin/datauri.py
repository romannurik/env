#!/usr/bin/env python

# Copyright 2010 Google Inc.
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#      http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import base64
import sys
import mimetypes


def to_data_uri(data, file_name):
  '''Takes a file object and returns its data: string.'''
  mime_type = mimetypes.guess_type(file_name)
  return 'data:%(mimetype)s;base64,%(data)s' % dict(mimetype=mime_type[0],
      data=base64.b64encode(data))


def main():
  print to_data_uri(open(sys.argv[1], 'rb').read(), sys.argv[1])


if __name__ == '__main__':
  main()