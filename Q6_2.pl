#!/usr/bin/perl
use strict;
use warnings;

while ( defined( my $line = <DATA> ) )
{
  chomp $line; 
  if ( $line =~ /(\w+)(\w*)(\w+)/ )
  {
    print "'$1' is:  $1\n";
    print "'$2' is:  $2\n";
    print "'$3' is:  $3\n";
  }
}

__END__
freedom