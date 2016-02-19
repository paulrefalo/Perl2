#!/usr/bin/perl
use strict;
use warnings;

$| = 1;

for ( 1 .. 20 )
{
  long_operation( $_ );
  print "$_\r";
}

sub long_operation
{
  my $arg = shift;
  print "Processing element $arg\n" unless $arg % 5;
  sleep 1;
}