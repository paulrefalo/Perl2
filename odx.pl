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
 
my $count = 0;
my $buffer;
my $full;
my $octal;

open my $fh, '<', $file or die "Couldn't read file: $!\n";
while ( read $fh, my $element, 1 )
{
  $count++;
  $buffer .= $element;
  $full = ( $count % 16 );
  if ( $full == 8 )
  {
    print "\n";
  }
  
  
  ## -c option.  
  if ( $mode == 0 )
  {
    $octal = ord($element);
    if ( $octal >= 040 && $octal <= 0176 )
    {
      print "$element";
      ## printf "%o ", $element;
    }
    elsif ( $full == 0 )
    {
      printf "%.6x ", $buffer;
      $buffer = 0;
      $count = 0;
    }
  }
  ## print all as hexadecimal equivalent.  no -c
  if ( $mode > 0 && $full == 0 )
  {    
    $buffer =~ /(.*)/ and print hex unpack( "%16C*", $1 ), " ";
    $buffer = 0;
    $count = 0;
  }
}