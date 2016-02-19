#!/usr/bin/perl
use strict;
use warnings;

## Call with:  ./word_counter2.pl 5 /software/Perl2/lesson3project1.txt
my %count;

my $word_length = shift @ARGV;
print "$word_length\n";
die "No arguments given.\n" unless @ARGV > 0;

while ( $_ = <> ) # or die "No arguments given\n";
{
  my @words = split;
  my $counter = 0;
  foreach ( @words )
  {
    if ( length($words[$counter]) > $word_length )
    {
      $count{$_}++;
    }
    $counter++;
  }
}


print "$_: $count{$_}\n" foreach sort keys %count;