#!/usr/bin/perl
use strict;
use warnings;

foreach my $text ( qw(Matt bats the ball at Atticus) )
{
  print qq{"$text" }, $text =~ /at/ ? "matches" : "does not match", " /at/\n";
}
