#!/usr/bin/perl
use strict;
use warnings;

my @row0 = qw(O O O O O);
my @row1 = qw(O O O O O);
my @row2 = qw(O O O O O);
my @row3 = qw(O X O X O);
my @row4 = qw(O O X O O);

OUTERSPACE: for my $row_index ( 0 .. 4 )
{
  my @row = $row_index == 0 ? @row0
          : $row_index == 1 ? @row1
          : $row_index == 2 ? @row2
          : $row_index == 3 ? @row3
          :                   @row4;
  for ( my $column_index = 0; $column_index <= $#row; $column_index++ )
  {
    if ( $row[$column_index] eq 'X' )
    {
      print "Found at [ $row_index, $column_index ]\n";
      last OUTERSPACE;
    }
  }
}
  