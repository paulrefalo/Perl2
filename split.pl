#!/usr/bin/perl
use strict;
use warnings;

while ( <DATA> )
{
  chomp;
  my @tokens;

  @tokens = split /[;:=]+\s*/, $_, 3;
  print "split P, E, 3\t", markup( @tokens ), "\n";

  @tokens = split /[;:=]+\s*/;
  print "split P\t\t", markup( @tokens ), "\n";

  @tokens = split;
  print "split\t\t", markup( @tokens ), "\n"
}

sub markup
{
  '|' . join( '|', @_ ) . '|';
}

__DATA__
Part: Cowling==; Cost: $71; Size: 48"
:peter:100:101:Peter Scott:/home/peter:/bin/tcsh:
The three virtues of a Perl programmer are: Impatience, Hubris, and Laziness - Larry Wall