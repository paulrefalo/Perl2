#!/usr/local/bin/perl                                                                                                
use strict;                                                                                                          
use warnings;                                                                                                        
                                                                                                                     
die "USAGE: $0 File" unless @ARGV;                                                                                   
my @args = @ARGV;                                                                                                    
my $option = "hex";     # Defaults to hex if the -c flag isn't used                                                  
my $file = "";                                                                                                       
                                                                                                                     
# Determine whether user entered the -c flag or not.  This determines the mode of printing.                          
foreach my $arg (@args){                                                                                             
        if($arg eq '-c'){                                                                                            
                $option = 'octal';                                                                                   
        }                                                                                                            
                                                                                                                     
        if(-f $arg){                                                                                                 
                $file = $arg;                                                                                        
        }                                                                                                            
}                                                                                                                    
                                                                                                                     
                                                                                                                     
open my $fh, '<', $file or die "Couldn't read file: $!\n";                                                           
                                                                                                                     
while(read $fh, my $buffer, 16){                                                                                     
        foreach (split(//, $buffer)){                                                                                
                if($option eq 'hex'){                                                                                
                        # Convert all characters to hex                                                              
                        printf("%06x ", ord($_));                                                                    
                                                                                                                     
                }                                                                                                    
                                                                                                                     
                elsif($option eq 'octal'){                                                                           
                        # Only print characters between 040 and 0176                                                 
                        if(ord($_) >= 32 && ord($_) <= 126){            # First convert 040 to decimal 32 and 0176 to
 # decimal 126 before doing conversion                                                                                 
                                printf("%#.03o ", ord($_));                                                          
                                                                                                                     
                        }                                                                                            
                }                                                                                                    
        }                                                                                                            
}                                                                                                                    
close($fh);  