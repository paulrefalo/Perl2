#!/bin/sh

netstat|perl -nle '{ if (3..12) { (@c=split(" ")) && ( print +(split ":",$c[$#c - 1 ])[0]  ) } }'