#!/usr/bin/perl
use strict;
use warnings;

my $text = "I HAVE THREE APPLES AND FOUR ORANGES"; 
$text =~ /24\/5\/1819/i and print "Found Queen Victoria's birthday\n";
    
$text = "I have two tomatoes and one zucchini";
$text =~ m{7/7/1776}i or print "Didn't find American Independence Day\n";