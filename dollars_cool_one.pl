#!/usr/bin/perl

use strict;
use warnings;

my $file = $ARGV[0];
my $total;

open my $fh, '<', $file;
foreach ( <$fh> ) {
    while ( /\$(\d+\.*\d\d)|(\d+\.\d\d\D)/g ) {
        $total += $1 if ( $1 );
        $total += $2 if ( $2 );
    }
    s/\$*(\d+\.\d\d\D)/\$$1/g;
    print "$_";
}

printf "Total: \$%.2f\n", $total;