#!/usr/bin/env sh
awk '{ s += int($1 / 3) - 2 } END {print "part 1: "s}' input.txt

awk '{
    x = $1;
    do { 
        x = int(x / 3) - 2;
        s += x > 0 ? x : 0
    } while (x > 0)
} END { print "part 2: "s }' input.txt

