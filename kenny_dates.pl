#!/usr/bin/perl
use strict;
use warnings;

my %month_number_of = (	january => 1,
			february => 2,
			march => 3,
			april => 4,
			may => 5,
			june => 6,
			july => 7,
			august => 8,
			september => 9,
			october => 10,
			november => 11,
			december => 12,
);

while (@ARGV) {
	my $file = "@ARGV";
	shift @ARGV;
	print "$file\n"; #test to see what the value of $file is
	open (CURRENT_FILE, "<", $file) or die "Could not open file '$file' $!";
	foreach my $line (<CURRENT_FILE>) {
		chomp $line;
		print "$line\n"; #test to see if it read $line correctly
		# if ($line =~ m/(\w.+? )/)  {
		if ( $line =~ /(\w+)/ )  {
			my $month_name = $1;
			$month_name = lc($month_name);
			print "$month_name\n"; #test again
			print "$month_number_of{$month_name}\n"; #test failed
		}
		else {
			print "'$line' doesn't have a month in it!\n";
		}
	}
}