#!/usr/bin/perl
use strict;
use warnings;

# To run:  For example: ./reg_grep2.pl -v perl ./*.pl or ./reg_grep2.pl -i -v Test ./*.test.

my $char = '-';
my $exp;

if ( @ARGV > 0 )
{
  my $arg1 = shift @ARGV;
  if ( index( $arg1, $char ) == 0 )
  {
    my $arg2 = shift @ARGV;
    if ( index( $arg2, $char ) == 0 ) { $exp = shift; &opt_both( $exp ) } ## I have both argument options
    elsif ( $arg1 eq "-v" ) { $exp = $arg2; &opt_v( $exp ); } # I have one arg which is -v
    elsif ( $arg1 eq "-i" ) { $exp = $arg2; &opt_i( $exp ); } # I have one arg which is -i   
    else { die "I don't have an option for that argument.\n"; } # This shouldn't happen.
  }
  else { $exp = shift; &no_opt( $exp ); }  ## There are no argument options.
}

sub opt_both
{
  my $regex = $exp;
  while ( $_ = <> )
  {
    print if $_ !~ /$regex/i;   # for both options
  }
  return;
}

sub opt_v
{
  my $regex = $exp;
  while ( $_ = <> )
  {
    print if $_ !~ /$regex/;   # for -v option, if the line does NOT match
  }
  return;
}

sub opt_i
{
  my $regex = $exp;
  while ( $_ = <> )
  {
    print if $_ =~ /$regex/i;  # for -i option, if the line matches but case insensitive
  }
  return;
}

sub no_opt
{
  my $regex = $exp;
  while ( $_ = <> )
  {
    print if $_ =~ /$regex/;  # for no options input
  }
  return;
}