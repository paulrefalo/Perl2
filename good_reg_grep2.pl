#!/usr/bin/perl
use strict;
use warnings;

my $v;
my $i;
my $regex;

#loop through each command line argument to test for flags
foreach (@ARGV) {
        if ($ARGV[0] =~ /-v/) {$v = 1; shift;}
        if ($ARGV[0] =~ /-i/) {$i = 1; shift;}
        }

#assign regex after flags
$regex = shift;

#Test input file as remaining command line input
while ( $_ = <> )
{
   if ($i && $v){print if $_ !~ /$regex/i;}
   elsif ($i){print if $_ =~ /$regex/i;}
   elsif ($v){print if $_ !~ /$regex/;}
   else {print if $_ =~ /$regex/;}
}