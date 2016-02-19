#!/usr/bin/perl
use strict;
use warnings;

my ($schnauzer, $mackerel) = (7, 12);
my $species = 'fish';
my %current_count = ( mammal => 1001, fish => 7269 );
( $species eq 'mammal' ? $schnauzer : $mackerel ) += $current_count{$species};

print "$schnauzer, $mackerel\n";