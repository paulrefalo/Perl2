#!/usr/bin/perl
use strict;
use warnings;

# 0, 1, I and O are not used in airline ticket locators to avoid ambiguity in print
my $pc = '[A-HJ-NP-Z2-9]';

while ( defined( my $line = <DATA> ) )
{
  chomp $line;
  print "'$line' contains a date\n"
    if $line =~ s{\d\d/\d\d/\d\d}(*****);
  print "'$line' contains a zip code\n"
    if $line =~ s/\d\d\d\d\d/*****/;
  print "'$line' contains a variable declaration\n"
    if $line =~ s/my\s[\$\@\%][A-Za-z]/*****/;
  print "'$line' contains a air ticket locator\n"
  if $line =~ s/$pc$pc$pc$pc$pc$pc/*****/;
}

__END__
This line shouldn't match anything
Easter falls on 24/04/11 next year
O'Reilly School of Technology, Sebastopol, CA 95472
Pi is approximately 3.14159265
foreach my $pet ( @animals )
My reservation is N2QVYX
Not a valid reservation code: ABC10I