#!/usr/bin/perl
use strict;
use warnings;

my %length;

my @filenames = @ARGV;

foreach my $filename ( @filenames )
{
  my ($artist, $title) = split '-', $filename;
  @ARGV = $filename;

  while ( defined( my $line = <> ) )
  {
    chomp $line;
    my ($album, $length, $genre) = split ':', $line;
    $length{$artist} += $length;
  }
}

foreach my $artist ( sort keys %length )
{
  print "$artist has a total of $length{$artist} in music\n";
}

__END__

  my ($artist, $title) = split '-', $filename; 
  my @array = split '/', $artist;
  $artist = $array[-1];
  print "$artist and $title\n";
  