#!/usr/bin/perl
use strict;
use warnings;

for ( prompt(); <STDIN>; prompt() )
{
  print "Input received:  ";
  print;
  last if /Quit/i;
}

sub prompt { print "Input: " }