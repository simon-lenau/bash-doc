#!/bin/bash

# Your string containing newlines
string="line1
line2
line3"

# Use awk to split the string at newlines, add an initial character to each line, and print
echo "$string" | awk '{print "Prefix: " $0}'
