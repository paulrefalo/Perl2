#!/usr/bin/perl
use strict;
use warnings;

my $regex = shift;

while ( <> )
{
  print if /$regex/;
}
