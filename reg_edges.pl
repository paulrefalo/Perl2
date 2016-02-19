#!/usr/bin/perl
use strict;
use warnings;

my @regexes = qw( \A[aeiou] [aeiou]\z \A[aeiou]+\z );
printf "%40s%13s%13s%13s\n", 'Regex:', @regexes;

while ( my $line = <DATA> )
{
  chomp $line;
  printf "%40s", $line;
  foreach my $regex ( @regexes )
  {
    if ( $line =~ /$regex/i )
    {
      printf "%13s", "   X   ";
    }
    else
    {
      printf "%13s", "";
    }
  }
  print "\n";
}   

__END__
Neither beginning nor ending in a vowel
A line that starts in a vowel
There's a vowel on the end of this line
A vowel at the start and end here
IOU