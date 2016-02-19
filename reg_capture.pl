#!/usr/bin/perl
use strict;
use warnings;

while ( my $line = <DATA> )
{
  chomp $line;
  if ( $line =~ /\b(\d{5})\b/ )
  {
    print "Captured:  $1\n";
  }
  else 
  {
    print "No match for '$line'\n";
  }
}

__END__
Sebastopol, CA 94572
20500 is the zip code of the White House
Pi is about 3.14159265, give or take
The Statue of Liberty is at 10004-1467
2147483647 is MAXINT on my machine