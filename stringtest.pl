#!/usr/bin/perl
use strict;
use warnings;

my $input;
if ( defined( $input ) && length( $input ) ) 
{
  print "\$input is not the empty string\n";
}   
else
{
  print "\$input is the empty string\n";
}