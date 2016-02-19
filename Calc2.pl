#!/usr/bin/perl
use strict;
use warnings;

my $INVALID = "Invalid statement\n";
my $Accumulator;

while ( print( "> " ) && defined( my $line = <> ) )
{
  chomp $line;
  my $ok;
  ($ok, $Accumulator) = execute( $line, $Accumulator );
  if ( $ok )
  {
    print "OK\n";
  }
  else
  {
    warn $INVALID;
  }
}

sub execute
{
  my ($line, $current) = @_;
  
  return if length $line == 0;

  my $operator_length = index $line, ' ';
  return monadic( $line, $current ) if $operator_length < 0;
  
  my $operator = substr $line, 0, $operator_length;
  my $operand = substr $line, $operator_length + 1;
  return dyadic ( $operator, $operand, $current );
  
}

sub monadic
{
  my ($operator, $current) = @_;

  if ( $operator eq 'EQUALS' )
  {
    if ( defined $current )
    {
      print " = $current\n";
    }
    else
    {
      print " (undefined)\n";
    }
    return ( 1, $current );
  }
  elsif ( $operator eq 'CLEAR' )
  {
    return ( 1, 0 );
  }
    elsif ( $operator eq 'EXIT' )
  {
    exit;
  }
  return;
}

sub dyadic
{
  my ( $operator, $operand, $current ) = @_;
  return ( 1, $current + $operand ) if $operator eq 'PLUS';
  return ( 1, $current - $operand ) if $operator eq 'MINUS';
  return ( 1, $current * $operand ) if $operator eq 'TIMES';
  return ( 1, $current / $operand ) if $operator eq 'OVER';
  return;
}
  