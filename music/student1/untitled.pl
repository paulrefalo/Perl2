#!/usr/bin/perl
# songz.pl

use strict;
use warnings;

$|++;

@ARGV > 0 or die "Need files ...\n";

for (@ARGV) {
	
	chomp;
	
	# Open file from @ARGV for reading
	open my $open_file, '<', $_ or die qq~ERROR: $!\n~;
	
	# Slurp Mode
	$/ = undef;
	
	# Data from File Handle
	my $data = <$open_file>; 
	
	# Generate filenames from file contents
	1 while $data =~ m~(?mix)
	
		^(?<FULL_INFO>(?<ARTIST>\w+):(?<TRACK>\w+)(?=:).*?(?=\n|$))
		(?{  
			
			# open file for writing
			open my $write_file, '>', "./$+{ARTIST}_$+{TRACK}.txt" or die qq&ERROR: $!&; 
			
			# write data to file
			print {$write_file} $+{FULL_INFO};
			
		})
	
	~g;
	
}