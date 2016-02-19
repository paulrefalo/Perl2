#!/usr/bin/perl
use strict;
use warnings;

my @regexes = qw( \d{5} \D\d{5}\D \b\d{5}\b );
printf "%40s%10s%10s%10s\n", 'Regex:', @regexes;

while ( my $line = <DATA> )
{
  chomp $line;
  printf "%40s", $line;
  foreach my $regex ( @regexes )
  {
    if ( $line =~ /$regex/ )
    {
      printf "%10s", "   X   ";
    }
    else
    {
      printf "%10s", "";
    }
  }
  print "\n";
}

__END__
Sebastopol, CA 94572
20500 is the zip code of the White House
Pi is about 3.14159265, give or take
The Statue of Liberty is at 10004-1467
2147483647 is MAXINT on my machine
My zip is _98362_