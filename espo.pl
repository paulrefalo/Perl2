#!/usr/local/bin/perl

#***************************************************************
# 
#  	Program: final_proj.pl
#
#	Author:  Anthony Esposito
#
#       NOTE: wish I could use the NetAddr::IP module ;-)
#
#***************************************************************

use strict;

#-----------
#  Variables
#-----------
my $file;
my $FH;
my $order_found = 0;
my $order;
my $line;
my @allow = "";
my @deny = "";
my $input;
my $allowed;
my $denied;

#------------------
#  Parse input file 
#------------------

$file = $ARGV[0];
open($FH, "<$file") or die "Error=> Couldn't read input file $file: $!\n";
while($line = <$FH>) {
	chomp($line);
	if (( $line =~ /^order/ ) && ( $order_found == 0 )) {
	  $order_found = 1;
	  $order = substr($line, 5);        # get directives after order
	  $order =~ s/^\s+|\s+$//g;         # trim leading and trailing spaces
	  if ($order =~ /\s/) {
            print "Spaces found in order directive\n";
            exit(2);
	  } elsif (( $order !~ "allow,deny" ) && ( $order !~ "deny,allow" )) {
	    print "Invalid order directives\n"; 
	  } 
	  next;	
  	} elsif (( $line =~ /^order/ ) && ( $order_found == 1 )) {
	  print "Multiple ORDER directives\n";
	  $order = substr($line, 5);        # get directives after order for last order found
	  $order =~ s/^\s+|\s+$//g;         # trim leading and trailing spaces
	  if ($order =~ /\s/) {
            print "Spaces found in order directive\n";
            exit(3);
	  } elsif (( $order !~ "allow,deny" ) && ( $order !~ "deny,allow" )) {
	    print "Invalid order directives\n"; 
	  } 
          next;	  
	} elsif ((( $line =~ /^allow/ ) || ( $line =~ /^deny/ )) && ( $order_found == 0 )) {
	  print "No order directive in input\n";
	  exit(1);
	} elsif ( $line =~ /^allow/ ) {
	  my $ip = substr($line, 11);
	  push @allow, $ip;
	  next;
	} elsif ( $line =~ /^deny/ ) {
	  my $ip = substr($line, 10);
	  push @deny, $ip;
	  next;  
	} else {
          next;
	}
	close($FH);
}  # end of while for parsing

#------------------------------------------------------------------------
#  Populate allow and deny directives, prompt for user input and evaluate
#------------------------------------------------------------------------
while(1) {
    print "Input address to test: ";
    $input = <STDIN>;
    chomp($input);

    if ($input eq 'quit') {       			# quit 
      last;                      
    }
    
    $denied = 0;
    $allowed = 0;
    
    print "Orders are:  $order\tand the Input is: $input\n";

    # based on order, evaluate input
    if ( $order =~ "allow,deny" ) {			# "allow,deny" logic
      
      for my $line( @allow ) {
         #  print "In the allow for loop.  Line is:  $line\n";
       if ( $input =~ /$line/ ) {             # works for exact matches only
          print "Allow loop: Input of $input matched to line $line\n";
          $allowed = 1;
          last;
        }
      }
    
      for my $line( @deny ) {
         print "In the deny for loop.  Line is:  $line\n";
        if ( $input =~ /$line/ ) {
          print "Deny loop: Input of $input matched to line $line\n";
          $denied = 1;
          last;
        }
      }	
      
      print "Allowed is:  $allowed\t and Denied is: $denied\n";
      
      if (( $allowed == 1 ) && ( $denied == 0 )) {		
	print "ALLOWED\n";
        next;
      } elsif (( $allowed == 1 ) && ( $denied == 1 )) {
      	print "REJECTED matched both\n";
      	next;
      } else {
      	print "REJECTED default\n";
      	next;
      } 
      
    } elsif ( $order =~ "deny,allow" ) {		# "deny,allow" logic
      
      for my $line( @deny ) {
        if ( $input =~ /$line/ ) {				# works for exact matches only
          $denied = 1;
          last;
        }
      }	
    		
      for my $line( @allow ) {
        if ( $input =~ /$line/  ) {
          $allowed = 1;
          last;
        }
      }
       
      if (( $allowed == 1 ) && ( $denied == 1 )) {		
	print "ALLOWED matched both\n";
        next;
      } elsif (( $allowed == 0 ) && ( $denied == 1 )) {
      	print "REJECTED\n";
      	next;
      } elsif (( $allowed == 0 ) && ( $denied == 0 )) {
      	print "ALLOWED default\n";
      	next;
      } 	
    }
    
} # end of while for input processing
__END__