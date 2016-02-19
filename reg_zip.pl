#!/usr/bin/perl
use strict;
use warnings;

while ( $_ = <DATA> )
{
  chomp;
  /(\d{5}(?:-\d{4})?)/ and print "Found zip: $1\n";
}

__END__
O'Reilly School of Technology
1005 Gravenstein Highway
Sebastopol, CA 95472-2811

O'Reilly Media
10 Fawcett Street
Cambridge, MA  02138

PSDT
136 E. 8th Street #232
Port Angeles, WA 98362-6129