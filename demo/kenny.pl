#!/usr/bin/perl
use strict;
use warnings;


my $file_to_read = $ARGV[0];

open FILE, '<', $file_to_read or die "$file_to_read not found";
my @read = ();
my %songz;
my $counter = 0;
while (<FILE>) {
	push @read, $_;
	my @get_info = split /:/, $read[$counter];
	if (!exists $songz{$get_info[0]}) {
		$songz{$get_info[0]} = $get_info[3];
	}
	else {
		$songz{$get_info[0]} += $get_info[3];
	}

	$counter++;
}
close FILE;

my @artist_names = keys %songz;
foreach my $artist (@artist_names) {
	print "$artist has a total of $songz{$artist} in music\n";
}