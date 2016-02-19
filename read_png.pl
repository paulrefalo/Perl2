#!/usr/bin/perl
use strict;
use warnings;

open my $fh, '<', '/software/Perl2/regmatch.png' or die "Couldn't read file: $!\n";
read $fh, my $buffer, 50;
$buffer =~ /IHDR(....)/ and print "Width = ", unpack ( "%N", $1 ), "\n";