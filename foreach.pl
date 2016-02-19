#!/usr/bin/perl
use strict;
use warnings;

$_ = "Outer\n";

print;

print foreach " Inner1\n", " Inner2\n", "Inner3\n";

print;