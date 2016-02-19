#!/usr/bin/perl

use strict;
use warnings;

my $songzfile = "songz.txt";

open my $fh, '<', $songzfile or die "Couldn't open $songzfile: $!\n";
while (my $writeline = <$fh>)
{
   chomp $writeline;
   my $artist_pos = index $writeline, ":";
   my $artist = substr $writeline, 0, $artist_pos;
   my $albuminfo= substr $writeline, $artist_pos+1, length($writeline);
   
   if (-e $artist)
   {     
      fileexistsnonempty( $artist, $albuminfo);
   }
   else
   {
      print "------------------------------------------------------------------------------------------------------------\n";
      print "\nCreated $artist file\n";    
      append( $artist, $albuminfo);           
   } 
   
}

sub fileexistsnonempty
{
   my($filename, $fileinfo) = @_;
   my $count = 0;
   open my $fhr, '<', $filename or die "Couldn't open $songzfile: $!\n";
   while (my $readline = <$fhr>)
   {
      chomp $readline;
      if(-z $filename)
      {
         print "$filename file is empty\n";
   	 append( $filename, $fileinfo);
      }
 
      else
      { 
         print "------------------------------------------------------------------------------------------------------------\n";
         print "fileinfo from songz.txt file is $fileinfo\n";
         print "readline from $filename file is $readline\n";	
         if ($readline eq $fileinfo)
         {
            $count = $count + 1;
         }
         
      }
   }
   if ($count == 0)
   {
      append( $filename, $fileinfo);
   }
return;   
}

sub append
{
   my($appendartist, $appendalbuminfo) = @_;
   print "------------------------------------------------------------------------------------------------------------\n";
   print "\nAppending $appendalbuminfo\n";
   open my $fh1, '>>', $appendartist or die "Couldn't open $appendartist: $!\n";
   print {$fh1}
   "$appendalbuminfo\n";  	
   close $fh1;        
        	            
}