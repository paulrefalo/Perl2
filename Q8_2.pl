#!/usr/bin/perl
use strict;
use warnings;

while ( $_ = <DATA> )
{
  chomp;
  if ( /(straw(?:berry|berrylike))/  )
  {
    print "$1\n";
  }
}

__END__
strawberrylike
