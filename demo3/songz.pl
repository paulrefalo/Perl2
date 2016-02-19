#!/usr/bin/perl
use strict;
use warnings;
use File::Basename;

#The file /software/Perl2/songz.txt contains the following text, which is equivalent to 
#all the information you had in the previous lesson's project, in the format artist, title,
#album, length, genre, separated by colons:
#George_Harrison:My_Sweet_Lord:All Things Must Pass:4.65:Folk rock
#Manfred_Mann:Blinded_by_the_Light:The Roaring Silence:7.12:Progressive rock
#Manfred_Mann:Do_Wah_Diddy:None:2.37:Pop rock
#Manfred_Mann:The_Mighty_Quinn:Mighty Garvey!:2.85:Rock
#The_Hollies:Bus_Stop:The Graham Gouldman Thing:2.9:Rock
#The_Hollies:Carrie_Ann:None:2.92:Rock 
#
#Write a program named songz.pl that reads the file (passed as a command line argument) 
#and uses it to create the same files (including the same content) that you were given in
#the previous lesson. The files should be located in your perl2 directory.

my $inline;  #line from input file
my @input_song;  #hold fields of song just input

die "Usage: ./songz.pl /software/Perl2/songz.txt" unless (@ARGV > 0); 
die "Sorry will only read songz.txt" unless (basename($ARGV[0]) eq 'songz.txt');

while ($inline=<>) {
     chomp $inline;
     @input_song = split(/:/, $inline);
     make_file(@input_song);  #let a subroutine create the needed files     
}


sub make_file {
#take line of input from songz.txt and make a file out of it
  my @song = @_;
  my $artist = $song[0];
  my $title = $song[1];
  my $album = $song[2];
  my $song_length = $song[3];
  my $genre = $song[4];
  
  #create filename
  my $EXT_FILE = $artist."-".$title;
  
  #create file content
  my $content = $album.":".$song_length.":".$genre;
  
  #open file for writing
  open my $fh, '>', $EXT_FILE or die "Couldn't open $EXT_FILE: $!\n"; 

  #write content to file
  print {$fh} $content;
  
  close($fh);  

}
