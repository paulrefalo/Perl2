#!/usr/bin/perl
use strict;
use warnings;

while ( my $file = glob "/etc/rc[1-4].d/K1*" )
{
  print "Matching file:  $file\n";
}