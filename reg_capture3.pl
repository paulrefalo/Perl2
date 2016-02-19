#!/usr/bin/perl
use strict;
use warnings;

use Socket;

while ( <DATA> )
{
  chomp;
  if ( /(\S+)\s+is\s+(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})/ )
  {
    my ($name, $ip) = ($1, $2);
    my $cname = gethostbyaddr( inet_aton( $ip ), AF_INET );
    print "$name -> $ip -> $cname\n";
  }
  elsif ( /(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})\s+is\s+(\S+)/ )
  {
    my ($ip, $name) = ($1, $2);
    my $lookup;
    if ( defined( $lookup = gethostbyname( $name ) ) )
    {
      $lookup = inet_ntoa( $lookup );
    }
    else
    {
      $lookup = "Couldn't resolve!";
    }
    print "$ip -> $name -> $lookup\n";
  }
  else
  {
    print "No match for '$_'\n";
  }
}

__END__
www.oreillyschool.com is 63.171.219.89
This line won't match
208.201.239.101 is www.perl.com
157.166.226.25 is cnn.com