#!/usr/bin/perl
use strict;
use warnings;

while ( my $line = <DATA> )
{
  chomp $line;
  if ( $line =~ /[A-Z]+\s+\d+/ )
  {
    print "One or more spaces matched\n";
  }
  if ( $line =~ /[A-Z]+ \d+/ )
  {
    print "One space matched\n";
  }
}

__END__
ASLKDKDSMV    93849384598