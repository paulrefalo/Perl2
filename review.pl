#!/usr/bin/perl
use strict;
use warnings;

my $CD_LENGTH = 80;

my $index = 1;

my %song_length = ("Fixing a Hole" => 2 + 2/60, "Lovely Rita" => 2 + 4/60, "A Day in the Life" => 5 + 33/60);
my @songs = keys %song_length;
print "I have " . @songs . " MP3 files\nTheir lengths in minutes are:\n";

foreach my $title ( keys %song_length )
{
  printf "#%2d: %-30s %5.2f\n", $index++, $title, $song_length{$title};
}

if ( total_length( %song_length ) < $CD_LENGTH )
{
  print "I can fit all of these on a CD.\n";
}
else
{
  print "I can't fit all of these on one CD!\n";
}  

sub total_length
{
  my %media = @_;
  
  my $total = 0;
  foreach my $length ( values %media )
  {
    $total += $length;
  }
  return $total;
}