#!/usr/bin/perl
use strict;
use warnings;

while ( $_ = <DATA> )
{
  chomp;
  /\b(\S+berr(?:y|ies))/ and print "Enfruitened:  $1\n";
}

__END__
We have strawberries,
and "whateverberries,"
and a giant gooseberry
on a big plate with a lingonberry pie!