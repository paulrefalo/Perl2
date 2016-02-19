#!/usr/bin/perl
use strict;
use warnings;

my $author = "Bradbury";
my $path = "lookinhere";
my $regex = "$path ";

## /\A(?:\b\/*/w+\/*\b) was written by (?:\b.*)\z/

if ( my $regex =~ /lookinhere was written by Bradbury/ )
  { print "It's a match.\n $regex\n"; }

## perl -le "print q/Don't stop thinking about tomorrow/" 

__END__
