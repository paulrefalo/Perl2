#!/usr/bin/perl
use strict;
use warnings;

while ( my $line = <DATA> )
{
  chomp $line;
  if ( $line=~ /(\d)/ && $line =~ /([^4]+)/ )
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