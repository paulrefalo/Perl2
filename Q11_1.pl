#!/usr/bin/perl
use strict;
use warnings;

while ( <DATA> )
{
  if ( /.*,\s+(\w+),/ )
  { print "$1 captured\n"; }
}

__END__
one, two, three, four... go!