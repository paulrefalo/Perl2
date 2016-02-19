#!/usr/bin/perl
use strict;
use warnings;

my ( $artist, $found, $song_title, $album, $track_time, $genre, $file, $inc, $count ); 
my $entry;
my @artists;
my @totals;

while ( defined( $entry = <> ) )
{
  # grab track time from $entry
  chomp $entry;
  ($album, $track_time, $genre) = split ":", $entry, 3;  #  get $track_time

  # grab artist name from file name 
  my $current_artist = $ARGV;  # define current artist from file name
  ($file, $song_title) = split "-", $ARGV, 2;  # $file and $song per $entry
  my ($term1, $term2, $term3, $term4, $artist) = split "/", $file, 5;  # get $artist  
  $found = -1;  # set $found less than zero to check against list
  
  if ( @artists )
  {
    $inc = 0;
    while ( $inc <= @artists )
    {
      if ( lc($artists[$inc]) eq lc($artist) )  # the artist is already in the list
      {
        $totals[$inc] = ( $totals[$inc] + $track_time );
        $found = 1;
      }
      $inc++;
    }

    if ( $found < 0 )   # the artist is NOT in the list yet
    {
      push (@artists, $artist);
      push (@totals, $track_time);
    }  
  }
  else  #if @artists array is empty, assign for element to each array
    {
     $artists[0] = $artist;
     $totals[0] = $track_time;
    }
}

$count = 0;
while ( $count < @artists )
{
  print "$artists[$count] has a total of $totals[$count] in music\n";
  $count++;
}  
  