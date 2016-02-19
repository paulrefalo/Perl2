#!/usr/bin/perl
use strict;
use warnings;

my $png_file;
my $min_octal = oct(040);
my $max_octal = oct(0176);
my $arg_count = @ARGV; 

if ($arg_count == 1) {
  $png_file = shift;
}
elsif ($arg_count == 2) {
  if ($ARGV[0] eq "-c") {
    $png_file = $ARGV[1];
    }
  else {
    print "Error: Incompatible flag.\n";
    die "Usage: od.pl [-c] <image_filename>\n";
  }
}
else {
  print "Error: Improper Usage\n";
  die "Usage: od.pl [-c] <image_filename>\n";
}

open my $fh, '<', $png_file or die "Couldn't read file $1\n";
my $count = 0;

while (read $fh, my $buffer, 16)
{
  my $num_str = unpack("%n", $buffer);
  my $oct_str = sprintf ("%4o", $num_str);

  if ($arg_count == 2) {
    if ($num_str >= $min_octal && $num_str <= $max_octal) {
      print "$oct_str ";
    }
    else {
      print sprintf ("%4x ", $num_str);
    }
  }
  else {
    print sprintf ("%4x ", $num_str);
  }
  
  if ($count > 17) {
    print "\n";
    $count = -1;
  }
  $count++;
}