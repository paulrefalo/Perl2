#!/usr/bin/perl
use strict;
use warnings;

while ( my $line = <DATA> )
{
  chomp $line;
  if ( $line =~ /((\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3}))/ )
  {
    print "Found an IP address: $1\n";
    print "First  octet: $2\n";
    print "Second octet: $3\n";
    print "Third  octet: $4\n";
    print "Fourth octet: $5\n";
  }
  else
  {
    print "No match for '$line'\n";
  }
}

__END__
www.oreillyschool.com is 63.171.219.89
This line won't match
208.201.239.101 is www.perl.com