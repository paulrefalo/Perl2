#!/usr/bin/perl

use strict;

use warnings;

for my $name ( "aa" .. "zz" ) {

  open my $fh, '>', $name or die "Can't open $name: $!\n";

  print {$fh} "\U$name\n";

}

for my $name ( glob "*q*" ) {

  open my $fh, '<', $name or die "Can't open $name: $!\n";

  print &lt;$fh>;

}

unlink for glob "*q*";

my @files = glob "??";

print "Remaining: " . @files, "\n";