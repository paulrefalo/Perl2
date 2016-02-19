#!/usr/bin/perl

use strict;
use warnings;

my %count;
my ($num1,$filename,$args) = " ";
my @words;

$args 	  = scalar(@ARGV);

if($args >= 1)
{
   $num1 	= $ARGV[0];
   $filename 	= $ARGV[1];
   open INFILE, "< $filename" or die "Can not open $filename : $!";
}else {  die "Error: Incorrect number of arguments \n"; }


while (<INFILE>)  
{
  # foreach (split);$count{$_}++; if (length($_) >= $num1);
  foreach (split)
 {
    if (length($_) >= $num1)
    {
        $count{$_}++;
    	#print "$_ ", length($_) ,"\n";	
    }
    else { die "Error: word Length error  \n"; }   
 }
 
}

print "$_: $count{$_}\n" foreach sort keys %count;