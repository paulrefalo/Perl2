#!/usr/bin/perl
use strict;
use warnings;

my $dir = '.';
opendir my $dh, $dir or die "Couldn't open $dir: $!\n";
while ( my $file_name = readdir $dh )
{
  # next if $file_name =~ /\A\.\.?\z/;
  print "$dir: $file_name\n";
}
closedir $dh;

$dir = '/etc';
opendir $dh, $dir or die "Couldn't open $dir: $!\n";
for my $file_name ( readdir $dh )
{
  # next if $file_name =~ /\A\.\.?\z/;
  print "$dir: $file_name\n";
}