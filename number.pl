#!/usr/bin/perl
use strict;
use warnings;

my $line;
my $count = 1;
printf "%5d %s", $count++, $line while defined( $line = <STDIN> );
