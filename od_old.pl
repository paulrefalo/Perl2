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
 
open my $fh, '<', $file or die "Couldn't read file: $!\n";


while ( <> )
{
  read $fh, my $buffer, 16;
  if ( $mode == 0 )
  {
    print "Working with -c\n";
    if ( $buffer > 040 && $buffer < 0176 )
    {
      print oct unpack( "%N", $buffer ), " octagon \n";     ## if it is octal 040 - 0176 print as is
    }
    else
    {     
      $buffer =~ /(.*)/ and print hex unpack( "%N", $1 ), " hexagon \n";
    }
  }
  if ( $mode > 0 )
  {  
    $buffer =~ /(.*)/ and print hex unpack( "%S", $1 ), "\n";
  }
}