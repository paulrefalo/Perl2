#!/usr/bin/perl
use strict;
use warnings;

my @strings = qw(pot pout pet sip nit snip spit);
my @regexes = qw(p[aeiou]t [snp]i[tp]);

printf "%10s%13s%13s\n", 'Regex:', @regexes;
foreach my $text ( @strings )
{
  printf "%10s", $text;
  foreach my $regex ( @regexes )
  {
    if ( $text =~ /$regex/ )
    {
      printf "%13s", " x ";
    }
    else
    {
      printf "%13s", "";
    }
  }
  print "\n";
}
