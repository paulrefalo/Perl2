#!/usr/bin/perl
use strict;
use warnings;
 
my %count;
my $file = 'tox.txt';
open my $fh, '<', $file or die "Could not open '$file' $!";
while (my $line = <$fh>) {
    chomp $line;
    #foreach my $str ( $line ) {	## split /\s+/,
    $count{$line}++;    
}
 
foreach my $str (sort keys %count) {
    print "$str, $count{$str}\n";  
}