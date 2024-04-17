#!/bin/bash

# Your string containing newlines
string="https://bla.bla/eins/zwei/drei/"
stringb="bla.bla/eins/zwei/drei/"

# Use awk to split the string at newlines, add an initial character to each line, and print
# echo "$string" |
#     sed \
#         -e 's/[\/:]/;/g' |
#         sed \
#         -e 's/;\{2,\}/;/g'  #| awk -F\[\;\] -v f=1 -v t=2 '{for(i=f;i<=t;i++) printf("%s%s",$i,(i==t)?"\n":OFS)}'

echo "$string" |
    sed \
        -e 's/\([^\/]\)[\/][^\/].*/\1/g' 
        # -e 's/\([^\/]*[\/]\{2,\}[^\/]*\).*$/>\1</g' 
        # -e 's/\([^\/]*[\/]\{2,\}[^\/]*\).*$/>\1</g' 