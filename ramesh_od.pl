#!/usr/bin/perl
use strict;

my $bytesToProcess = 16;
my $fileName = '/software/Perl2/regmatch.png';

print "Processing $bytesToProcess bytes...\n";

open FILE, "<:raw", $fileName or die "Couldn't open $fileName!";

for my $offset (0 .. $bytesToProcess - 1)
{
    my $oneByte;
    read(FILE, $oneByte, 1) or die "Error reading $fileName!";
    printf "0x%04X\t0x%02X\n", $offset, ord $oneByte;
}

close FILE;