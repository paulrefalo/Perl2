#!/usr/bin/perl
use strict;
use warnings;

my ($artist, $title, $time, $album, $genre);
my $DATA_FILE = 'songs.data';
unless ($ARGV[0]) {
	print "Usage: $0 filename \n";
} else {
	foreach (<>) {
		my @lines = $_;
		foreach (@lines) {
			chomp $_;
			($artist, $title, $album, $time, $genre) = split ':', $_;
		}
		open my $fh, '>>', $DATA_FILE or die "Couldn't open $DATA_FILE: $!\n";
		print {$fh} "$title lasts $time minutes\n";
	}
}