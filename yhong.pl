#!/usr/bin/perl
use strict;
use warnings;

my $Min_Char = shift or die "Needs at least one argument\n";
if ($Min_Char =~ /\D/ ) { die "First argument needs to be an integer\n";}

my %count;

while ($_ = <>) { # although the lesson said not to use this form, you've not yet shown us the preferred method...and this uses $_ as requested.
   my @words = split /\b/;
   foreach (@words) {
      $count{$_}++ if length($_) >= $Min_Char;
   }
}

print "$_: $count{$_}\n" foreach sort keys %count;