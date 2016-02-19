#!/usr/bin/perl
use strict;
use warnings;

while ( $_ = <DATA> )
{
  chomp;
  if ( /\A\d{5}\z|\A\d{5}-\d{4}\z/ )
  {
    print "$_ is a match\n";
  }
}

__END__
123456789-987654321
97224-123485
40601
40601-1234

