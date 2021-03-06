#!/usr/bin/perl
use strict;
use warnings;

my $mode = 1;
my $file = $ARGV[0] if @ARGV == 1;

if ( @ARGV > 1 )
{
  $file = $ARGV[1] if $ARGV[0] eq "-c";
  $file = $ARGV[0] if $ARGV[1] eq "-c";
  $mode = 0;
}
 
my $count = -1;
my $num;
open my $fh, '<', $file or die "Couldn't read file: $!\n";
while ( read $fh, my $buffer, 1 )
{
  ## Formatting lines for 16 characters
  last if ( $count >= 120 );
  $count++;
  if ( ($count % 16) == 0 )
  { print "\n"; } 

 
  ## Get ASCII value of character with ord
  my $output = ord($buffer);
  ##  For -c option
  if ( $mode == 0 )
  {
    if ( $output >= 040 && $output <= 0176 )
    { printf "%3c ", $output; }
    else
    { printf "%3X ", $output; }
  }
  ##  For all hex option
  if ( $mode == 1 )
  {
    printf "%3X ", $output;
  }
}

print "All done here.\n";