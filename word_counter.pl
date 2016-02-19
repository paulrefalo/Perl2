#!/usr/bin/perl
use strict;
use warnings;

my %count;
while ( $_ = <> )  
{
  $count{$_}++ foreach split;
}

print "$_: $count{$_}\n" foreach sort keys %count;