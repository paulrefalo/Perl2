#!/usr/bin/perl
use strict;
use warnings;

foreach ( glob "{a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z}{a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z}" )
{
  open(my $fh, ">", "$_") or die "cannot open > output.txt: $!";
  print uc($_), "\n";
}