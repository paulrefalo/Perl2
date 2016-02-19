#!/usr/bin/perl
use strict;
use warnings;

# To run use:  ./songz.pl /software/Perl2/songz.txt

my $file = $ARGV[0];

open my $fh, '<', $file or die "Couldn't open $file: $!\n";
while ( my $line = <$fh> )
{
  chomp $line;
  my ($artist, $title, $album, $song_length, $genre) = split ":", $line, 5;  #  get necessary info
  
  my $new_file = join ( "-", $artist, $title );
  ##print "$new_file\n";
  open my $new_fh, '>', $new_file or die "Couldn't open $new_file:  $!\n";
  my $data = join ( ":", $album, $song_length, $genre);
  ##print "$data\n";
  print {$new_fh} $data;
}
    