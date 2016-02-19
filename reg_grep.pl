#!/usr/bin/perl
use strict;
use warnings;

my $regex = shift;

while ( $_ = <> )
{
  print if $_ =~ /$regex/;
}