#!/usr/bin/perl
use strict;
use warnings;

foreach ( glob "{a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z}{a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z}" )
{
  open(my $fh, ">", "$_") or die "cannot open $_";
  my $output = uc($_);
  print $fh "$output\n"; 				#print to each file
  
  if ( $_ =~ /q/ ) 					#print contents of each file with a q in the file name
  {
    print "Matching file:  $_\n";
    unlink;						#delete those files
  }  	
  close $fh;
}
my $num = 0;
my $dir = '.';		#count/print the number of files left that have two letters in their name
opendir my $dh, $dir or die "Cannot open $dir: $!";
while (my $name = readdir $dh)
{
  next unless $name =~ /^[a-z][a-z]$/;
  $num++;
}
  
print "The number of remaining files with two letters in the file names is:  $num\n";