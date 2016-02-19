#!/usr/bin/perl
use strict;
use warnings;

# To run:  For example: ./reg_grep2.pl -v perl ./*.pl or ./reg_grep2.pl -i -v Test ./*.test.

my ($negated, $case_insensitive);

while( $ARGV[0] =~ m/^-/ ) {		## Get options from command line
my $opt = shift; # remove from @ARGV
$negated = 1 if $opt eq '-v';
$case_insensitive = 1 if $opt eq '-i';
}

my $regex = shift;			## Get regex from command line

while ( <> ) {
if ( $negated ) {
if ( $case_insensitive ) {
print unless /$regex/i;
}
else {
print unless /$regex/;
}
}
else {
if ( $case_insensitive ) {
print if /$regex/i;
}
else {
print if /$regex/;
}
}
}