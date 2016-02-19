#!/usr/bin/perl
use strict;
use warnings;

while ( my $line = <DATA> )
{
  chomp $line;
  ## if ( $line =~ /\b([+-]?\d+\.?\d*)\b/ || $line =~ /\b([+-]?\d*\.\d+)\b/ )
  ## || $line=~ /\b(\s+\+?-?\d+\.\d*)\b/ || $line=~ /\b(\s+\+?-?\d*\.\d+)\b/
  if ( $line=~ /^\s+([+-]?\d+\.?\d*)$/ || $line =~ /^\s+([+-]?\d*\.?\d+)$/ )
  {
    print "Captured: $1\n";
  }
  else
  {
    print "No match for '$line'\n";
  }
}

__END__
 23
 2J8
 1.1.1
 42
 4.2
 0.2
 .1
 2.
 +1
 ++2
 -1
 --2
 +-5
 -+4
 +.1
 -.2