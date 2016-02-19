#!/usr/bin/perl
use strict;
use warnings;

##  To run:  ./od.pl /software/Perl2/regmatch.png or ./od.pl -c /software/Perl2/regmatch.png

print "The file path is:  $0\n";

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
  ## last if ( $count >= 120 );  ## Length control statement for troubleshooting
  $count++;
  if ( ($count % 16) == 0 )
  { print "\n" unless $count == 0; } 

 
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

