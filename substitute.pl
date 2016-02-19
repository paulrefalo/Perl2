#!/usr/bin/perl
use strict;
use warnings;

my $date = localtime();
$date =~ s/ (\d\d:\d\d:\d\d)// or die "$date not in expected format!\n";
my $time = $1;
while ( defined( my $line = <DATA> ) )
{
  chomp $line;
  $line =~ s/X_DATE_X/$date/;
  $line =~ s/X_TIME_X/$time/;
  print "$line\n";
}

__END__
The date is X_DATE_X today
and the time is X_TIME_X;
i.e., it is X_TIME_X on X_DATE_X
  