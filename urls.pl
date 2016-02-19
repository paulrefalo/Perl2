#!/usr/bin/perl
use strict;
use warnings;

# usage:  ./urls.pl urls.dat

my %scheme;
my %server;

while ( $_ = <> ) 
{
  chomp;
  if ( /(ftp|http|https):\/\/(.*\.\w+)\// )
  {
    $scheme{$1}++;
    $server{$2}++;
  }
}

my @schemes = sort { $scheme{$b} <=> $scheme{$a} } keys %scheme;
my @servers = sort { $server{$b} <=> $server{$a} } keys %server;

print "\nThe two most popular schemes are:  $schemes[0] and $schemes[1]\n\n";
print "The two most popular servers are:  $servers[0] and $servers[1]\n\n";

