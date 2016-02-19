#!/usr/bin/perl
use strict;
use warnings;

my (%description, %retail_price, %appearance);
my $MARKUP = 1.45;

while ( <DATA> )
{
  next if /\AItem ID/;
  my ($id, $desc, $cost, $color) = split /\s*\|\s*\$?/;
  $description{$id}  = $desc;
  $retail_price{$id} = $cost * $MARKUP;
  $appearance{$id}   = $color;
}

while ( my ($id, $desc) = each %description )
{
  printf "$desc : \$%.2f\n", $retail_price{$id};
}

__DATA__
Item ID|Description|Cost|Color
63784|Futon|$125.00|White
374895 | Tatami mat | $70.00 | Straw
273643 | Stone fountain | $210.00 | Gray
349875|Kimono|$743.00|Varies