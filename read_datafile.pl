#!/usr/bin/perl
use strict;
use warnings;

my $DATA_FILE = 'songs.data';

open my $fh, '<', $DATA_FILE or die "Couldn't open $DATA_FILE: $!\n";
while ( my $line = <$fh> )
{
  chomp $line;
  my $minute_pos = index $line, "'";
  my $second_pos = index $line, '"';
  my $minutes = substr $line, 0, $minute_pos;
  my $seconds = substr $line, $minute_pos + 1, $second_pos - $minute_pos -1;
  my $running_time = $minutes + $seconds /60;
  my $title = substr $line, $second_pos + 2;
  print "$title lasts $running_time minutes\n";
}
