#!/usr/bin/perl
use strict;
use warnings;

##	"w{xa,yb}z"
for my $file (qw{wxaz wybz wxaybz wxyz wabz}){
if( $file =~ /w(?:xa|yb)z/ ){
    print "YES $file does match the regex\n";
}
else{
    print "NO $file does NOT match the regex\n";
}
}

