#!/usr/bin/perl
use strict;
use warnings;

my $count = 2;
if ( $count < 1 && item_test() )
{
  print "Don't expect to see this\n";
}
else
{
  print "Failed conditional\n";
}

sub item_test
{
  print "Don't expect to see this either\n";
}