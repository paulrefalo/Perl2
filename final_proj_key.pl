#!/usr/bin/perl

use strict;

use warnings;

my $ALLOW_DENY = 1;

my $DENY_ALLOW = 2;

my $order;

my (%allow, %deny);

while ( <> )

{

  /\AOrder\s+(\w+),(\w+)/i and $order = process_order( $1, $2 );

  /\A(Allow|Deny)\s+from\s+([\w.]+)/i and process_pass( $1, $2 );

}

$order or die "No order directive in input\n";

for ( prompt(); my $address = <STDIN>; prompt() )

{

  chomp $address;

  last if $address =~ /\Aquit\z/i;

  if ( $order == $ALLOW_DENY )

  {

    if ( match( $address, keys %allow ) )

    {

      if ( match( $address, keys %deny ) )

      {

        reject();

      else

      {

        allow();

      }

    }

    else

    {

      reject();

    }

  }

  else

  {

    if ( match( $address, keys %deny ) )

    {

      if ( match( $address, keys %allow ) )

      {

        allow();

      }

      else

      {

        reject();

      }

    }

    else

    {

      allow();

    }

  }

}

sub prompt

{

  print "Input address to test: ";

}

sub process_order

{

  my ($first, $second) = @_;

  warn "Multiple ORDER directives\n" if $order;

  if ( $first =~ /allow/i && $second =~ /deny/i )

  {

    return $ALLOW_DENY;

  }

  elsif ( $first =~ /deny/i && $second =~ /allow/i )

  {

    return $DENY_ALLOW;

  }

  else

  {

    warn "Unknown ORDER directive\n";

    return;

  }

}

sub process_pass

{

  my ($pass, $where) = @_;

  ($pass =~ /allow/i ? $allow{$where} : $deny{$where})++;

}



# A little explanation here. We split the address and each

# candidate to test into their components between dots. There

# are two possible types of address:

# Symbolic: $address = a.b.c, $candidate = b.c => match

# Numeric: $address = 1.2.3.4, $candidate = 1.2.3 => match

# The symbolic kind is the same type of match, only we just reverse the

# component lists first, since we are testing for matches from the end.

sub match

{

  my ($address, @candidates) = @_;

  OUTER: for my $candidate (@candidates)

  {

    my @candidate_parts = split /\./, $candidate;

    my @address_parts = split /\./, $address;

    # If the candidate is more specific, we lose immediately

    @candidate_parts > @address_parts and return 0;

    if ( $address =~ /[a-z]/ ) # It's symbolic

    {

      @candidate_parts = reverse @candidate_parts;

      @address_parts = reverse @address_parts;

    }

    for my $index ( 0 .. $#candidate_parts )

    {

      $candidate_parts[$index] eq $address_parts[$index] or next OUTER;

    }

    return 1;

  }

  return 0; # Nothing matched

}

sub allow { print "ALLOWED\n" }

sub reject { print "REJECTED\n" }