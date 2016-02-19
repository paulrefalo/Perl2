#!/usr/bin/perl
use strict;
use warnings;

my @array = qw(a b c d e f g h);
$_ = 'z';
print "Before the loop: $_\n";  

foreach $_ ( @array )
{
  print "Inside the loop: $_\n";
}

print "After the loop: $_\n";