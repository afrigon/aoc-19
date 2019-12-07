#!/usr/bin/env sh
awk '{s+=int($1/3)-2} END {print s}' input.txt
