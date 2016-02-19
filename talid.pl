#!/usr/bin/perl
use strict;
use warnings;

my $arg;
my $case_insensitive;
my $regex;
my @files;
while( $arg = shift )
{
    if ($arg eq "-i") {
        $case_insensitive = "i";
    }elsif ($arg eq "-v" ) {
        $regex = shift;
    }else {
        push @files, $arg;
    }
}
push @ARGV, @files;

while ( $_ = <> )
{
    if( $case_insensitive && $regex ) { print if !($_ =~ /$regex/i);}
    elsif( $regex ){ print if !($_ =~ /$regex/);}
    
}