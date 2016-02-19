#!/usr/bin/perl
use strict;
use warnings;


while ( my $line = <DATA> )
{
  chomp $line;
  if ( $line =~ /\brap\b/ )
  {
    print "This sucker matches to 'rap':  $line\n";
  }
}


   


__END__
rap
scrap
trap
rappel
