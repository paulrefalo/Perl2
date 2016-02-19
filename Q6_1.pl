#!/usr/bin/perl
use strict;
use warnings;

while ( defined( my $line = <DATA> ) )
{
  chomp $line;
  print "'$line' contains a number\n"
   if $line =~ s/\d*\s*/PR/;

}

__END__
WORD

again?
wow