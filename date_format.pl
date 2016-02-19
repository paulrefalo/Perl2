#!/usr/bin/perl
use strict;
use warnings;

my $month;
while ( my $line = <> )
{
  chomp $line;
  if ( $line =~ /(.*)\s(\d\d*),\s(\d{4})/ )
  {
    $month = $1;
 
    if ( lc($month) eq "january" ) { $month = 1; }
    if ( lc($month) eq "february") { $month = 2; }
    if ( lc($month) eq "march" ) { $month = 3; }
    if ( lc($month) eq "april" ) { $month = 4; }
    if ( lc($month) eq "may" ) { $month = 5; }
    if ( lc($month) eq "june" ) { $month = 6; }
    if ( lc($month) eq "july" ) { $month = 7; }
    if ( lc($month) eq "august" ) { $month = 8; }
    if ( lc($month) eq "september" ) { $month = 9; }
    if ( lc($month) eq "october" ) { $month = 10; }
    if ( lc($month) eq "november") { $month = 11; }
    if ( lc($month) eq "december" ) { $month = 12; }
    
    print "$3-$month-$2\n";
  }
}


   