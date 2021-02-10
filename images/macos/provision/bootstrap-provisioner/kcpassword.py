#!/usr/bin/env python

# Port of Gavin Brock's Perl kcpassword generator to Python, by Tom Taylor
# <tom@tomtaylor.co.uk>.
# Perl version: http://www.brock-family.org/gavin/perl/kcpassword.html
# This script was taken from https://github.com/timsutton/osx-vm-templates/blob/master/scripts/support/set_kcpassword.py
# Distributed by MIT license, license can be found at the bottom of this script

import sys
import os

def kcpassword(passwd):
    # The magic 11 bytes - these are just repeated
    # 0x7D 0x89 0x52 0x23 0xD2 0xBC 0xDD 0xEA 0xA3 0xB9 0x1F
    key = [125,137,82,35,210,188,221,234,163,185,31]
    key_len = len(key)

    passwd = [ord(x) for x in list(passwd)]
    # pad passwd length out to an even multiple of key length
    r = len(passwd) % key_len
    if (r > 0):
        passwd = passwd + [0] * (key_len - r)

    for n in range(0, len(passwd), len(key)):
        ki = 0
        for j in range(n, min(n+len(key), len(passwd))):
            passwd[j] = passwd[j] ^ key[ki]
            ki += 1

    passwd = [chr(x) for x in passwd]
    return "".join(passwd)

if __name__ == "__main__":
    passwd = kcpassword(sys.argv[1])
    fd = os.open('/etc/kcpassword', os.O_WRONLY | os.O_CREAT, 0o600)
    file = os.fdopen(fd, 'w')
    file.write(passwd)
    file.close()

"""
The MIT License (MIT)
Copyright (c) 2013-2017 Timothy Sutton
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
"""