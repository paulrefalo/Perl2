#!/usr/bin/perl
use strict;
use warnings;

my $DATA_FILE = $ARGV[0] or die "No input file specified: $!\n";

open my $fh, '<', $DATA_FILE or die "Couldn't open $DATA_FILE: $!\n";

while (my $line = <$fh>) {
  
  # get file information
  chomp $line;
  my ($artist, $song, $album, $length, $type) = split /:/, $line;
  
  my $new_file = $artist.'-'.$album;
  my $new_contents = "$album:$length:$type";
  
  # create new files
  
  create_file($new_file, $new_contents);
  
}

sub create_file {
# create the new file

  my ($file, $contents) = @_;
  {
    open my $fh, '>', $file or die "Couldn't open $file for writing: $!\n";
    print {$fh} $contents;
  }

}