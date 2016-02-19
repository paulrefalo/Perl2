#!/usr/bin/perl                                                                                                                                                              
use strict;                                                                                                                                                                  
use warnings;                                                                                                                                                                
                                                                                                                                                                             
open(my $file,'<',shift);                                                                                                                                                     
                                                                                                                                                                             
while ( my $line = <$file>) {                                                                                                                                                 
        my($artist,$title,$album,$length,$genre) = split(':', $line);                                                                                                        
        #my $filename = "~/perl2/$artist-$title";  
        my $filename = join ( "-", $artist, $title );                                                                                                                              
        open(my $out, '>', $filename);                                                                                                                                    
        print $out "$album:$length:$genre";                                                                                                                               
}   