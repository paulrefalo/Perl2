#!/usr/bin/perl
use strict;
use warnings;
use File::stat;

my ($hex_data,$buffer, $x, $data, $i, $option);
my $j=0;
while(my $arg = shift @ARGV)
{
   if ($arg eq '-c')
   {
     $option =1;
   }
}
my $size = stat('/software/Perl2/regmatch.png')->size;
open my $fh, '<', '/software/Perl2/regmatch.png' or die "Couldn't read file: $!\n";
binmode($fh);
while ($x = read ($fh, $buffer, $size)) { 
  for ($i=0; $i<$size; $i++) 
  {
        $data = unpack("x$i C1", $buffer);
        if (defined($option) && ($data >= 040 && $data <= 0176))
           {
              printf "%2c ", $data;
           }
        else {
               printf "%02x ", $data;
        }
        $j++;
        if ($j==16)
        {
           print "\n";
           $j = 0;
        } 
  }
}  
close $fh;

