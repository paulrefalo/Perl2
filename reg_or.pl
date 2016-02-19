#!/usr/bin/perl
use strict;
use warnings;

while ( $_ = <DATA> )
{
  chomp;
  print "Captured:  $1\n" if /I have (apple) in stock/ || /I have (banana) in stock/ || /I have (cherry) in stock/;
}

__END__
I have apple in stock
You are the apple of my eye
Time flies like an arrow; fruit flies like a banana
I have cherry in stock
I have kiwi fruit in stock; no banana, sorry