#!/usr/bin/perl
use strict;
use warnings;

my @commands;
my $regex_operator = '';
unshift @commands, @ARGV;

if ($commands[0] =~ m/-[iv]/) {
	$regex_operator = shift @commands;
	$regex_operator =~ s/-//;
	if ($commands[0] =~ m/-[iv]/) {
		$regex_operator = $regex_operator . shift @commands;
		$regex_operator =~ s/-//;
	}
}
my $item_to_match = shift @commands;

foreach my $file (@commands) {
	open (FILE, "<", $file) or die "Could not open the file '$file' $!";
	foreach my $file_line (<FILE>) {
		if ($regex_operator eq 'iv') {
			print "$file_line\n" if $file_line !~ m/$item_to_match/i;
		}		
		elsif ($regex_operator eq 'i') {
			print "$file_line\n" if $file_line =~ m/$item_to_match/i;
		}
		elsif ($regex_operator eq 'v') {
			print "$file_line\n" if $file_line !~ m/$item_to_match/;
		}
		else {
			print "$file_line\n" if $file_line =~ m/$item_to_match/;
		}
		
	}
	close FILE;
}