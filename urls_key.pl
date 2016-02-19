#!/usr/bin/perl
use strict;
use warnings;

my (%scheme, %server);

while ( <ARGV> ) {

  m!(https?|ftp)://([\w.]+)/! and $scheme{$1}++, $server{$2}++;

}

my $i;

for ( sort { $scheme{$b} <=> $scheme{$a} } keys %scheme ) {

  print "$_: $scheme{$_}\n";
  last if $i++;
}

$i = 0;

for ( sort { $server{$b} <=> $server{$a} } keys %server ) {

  print "$_: $server{$_}\n";
  last if $i++;
}