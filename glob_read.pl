#!/usr/bin/perl
use strict;
use warnings;

print ".: $_\n"		for glob "*";

print "/etc: $_\n"	for glob "/etc/*";