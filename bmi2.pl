#!/usr/bin/perl
use strict;
use warnings;

die "Usage: $0 height (inches) weight (pounds)\n" unless @ARGV == 2;

my ($height, $weight) = @ARGV;
my $bmi = $weight * 703 / $height ** 2;

print $bmi < 18.5 ? "Underweight"
    : $bmi < 24.9 ? "Normal"
    : $bmi < 29.9 ? "Overweight"
    :               "Obese",
    "\n";