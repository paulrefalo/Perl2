#!/usr/bin/perl
use strict;
use warnings;

{
my $label = get_label( "report_file" );
add_title( $label );
}
sub get_label {
  return "imaginary label"
}
sub add_title
{
  print "Adding title of $_[0]\n";
}

# Pretend this is much later in the program...

$label = 'Nothing to do with the previous $label';
