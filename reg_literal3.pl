#!/usr/bin/perl
use strict;
use warnings;

foreach my $text ( "Stoplight", "Red Light", "Green means go" )
{
  print qq{"$text": };
  if ( $text =~ /sto/i && $text =~ /top/ )
  {  print "matches AND clause\n";  }
  elsif ( $text =~ /light/ || $text =~ /light/i )
  {  print "matches OR clause\n";  }
  else
  {  print "matches neither clause\n";  }
}
