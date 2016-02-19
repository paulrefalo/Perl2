#!/usr/bin/perl
use strict;
use warnings;

my $DATA_FILE = 'songs.data';

open my $fh, '>', $DATA_FILE or die "Couldn't open $DATA_FILE: $!\n";

print {$fh} <<'EOF';
2'02" Sgt. Pepper's Lonely Hearts Club Band
2'44" With A Little Help From My Friends
3'29" Lucy In The Sky With Diamonds
2'48" Getting Better
2'37" Fixing A Hole
EOF
close $fh;