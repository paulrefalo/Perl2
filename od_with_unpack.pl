#!/usr/bin/perl

use strict;
use warnings;

my ($print_option, $input_file);

if ( $ARGV[1] ) {
    if ( $ARGV[0] eq '-c' ) {
        $print_option = 'yes';
        $input_file   = $ARGV[1];
    }
    else {
        die "Invalid command line option: $ARGV[0]\n";
    }
}
else {
    $input_file = $ARGV[0];
    $print_option = 'no';
}

open my $fh, '<', $input_file or die "Couldn't read file: $!\n";

while ( read $fh, my $buffer, 16 ) {
    foreach my $char ( split('',$buffer) ) {
        my $hex =  unpack('H2', $char);
        my $oct = oct "0x$hex";
        if ( $oct > 39 && $oct < 177 && $print_option eq 'yes' ) {
            print chr($oct) . " ";
        }
        else {
            print "$hex ";
        }
    }
    print "\n";
}