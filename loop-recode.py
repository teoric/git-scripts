#!/usr/bin/env python2
# -*- coding: utf-8 -*-


"""
Recode text, e.g. old commit messages.

Allows UTF-8 or 8-bit input and returns UTF-8. Current configuration
expects German text, recognised by the presens of umlauts, Eszett, or
paragraph signs etc.
"""

import sys
import codecs
import regex  # needed as re cannot upcase non-ASCII chars
import fileinput

stderr = codecs.getwriter('utf-8')(sys.stderr)
stdout = codecs.getwriter('utf-8')(sys.stdout)


def is_german(line):
    u"""Guess whether a line is in German."""
    stderr.write(line)
    line = unicode(line)
    ret = regex.search(ur"(?i)[äöüßçéêè]", line) and True or False
    # not German enough: áâàêèíîì
    if not ret:
        if regex.search(ur'(?:§\s*\d+|´s)', line):
            ret = True
    return ret


for line in fileinput.input():
    try:
        line = line.decode("utf-8")
    except UnicodeDecodeError:  # line not valid UTF-8
        # First try Windows CP 1252, then MacRoman.
        new_line = line.decode("cp1252")
        if not is_german(new_line):
            line = line.decode("macroman")
        else:
            line = new_line
        stderr.write(line)
    stdout.write(line)
