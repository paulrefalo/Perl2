#!/usr/bin/perl
use strict;
use warnings;

$| = 1;
for ( 1 .. 100 )
{
 long_operation( $_ );
 spin_web( $_ );
}
sub long_operation
{
 my $arg = shift;
 print "Processing element $arg\n" unless $arg % 15;
 sleep 1;
}

sub spin_web
{
  my $var = shift;
  my @spinner = qw(- \ | / );
  my $score = ( $var % 4 );
  print "$spinner[$score]\r";
  ##sleep 1;
}