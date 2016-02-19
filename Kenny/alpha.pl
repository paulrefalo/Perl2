#!/usr/bin/perl -w
use strict;


foreach my $file ("AA" .. "ZZ") {
	my $file_contents = lc($file);
	open FILE, '+>', $file or die "Could not open $file: $!";
	print FILE "$file_contents";
	close FILE;
}
#pretending these files weren't just created so starting over

my @file_list = glob "*Q*";
foreach my $file (@file_list) {
	open my $fh, '<', $file or die "Could not open $file: $!";
	foreach my $file_row (<$fh>) {
		print "Content of $file: $file_row\n";
	}
	close $fh;
	unlink $file or die "Could not unlink $file: $!";
}
#Okay now off to count the remaining files that didn't get the axe.
@file_list = glob "[a-zA-Z][a-zA-Z]";
my $total_files_remaining = ($#file_list + 1);
print "The total number of files remaining with two characters in the name that didn't get deleted (sorry q): $total_files_remaining\n";