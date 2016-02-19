#!/usr/bin/perl
use strict;
use warnings;

while ( defined( my $line = <DATA> ) )
{
  chomp $line;
  print "'$line' contains a number\n"
   if $line =~ s/\d+/~~~~~/
   || $line =~ s/d*\.\d+/#####/
   || $line =~ s/d+\.\d*/*****/;
}

__END__
One kind of number: 12.
Another kind of number: .34
A third kind of number: 12.34
A plain integer: 1234

No number in this line, not even a period
Or in this one