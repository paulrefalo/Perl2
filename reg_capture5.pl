#!/usr/bin/perl
use strict;
use warnings;

while ( $_ = <DATA> )
{
  chomp;
  if ( /(.*),\s+(\w\w)\s+(\d{5})/ )
  {
    my ($city, $state, $zip) = ($1, $2, $3);
    printf "City:  %-20s; State: $state, Zip: $zip\n", $city;
  }
}

__END__
O'Reilly School of Technology
1005 Gravenstein Highway
Sebastopol, CA 95472

O'Reilly Media
10 Fawcett Street
Cambridge, MA  02138

PSDT
136 E. 8th Street #232
Port Angeles, WA 98362