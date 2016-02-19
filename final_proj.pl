#!/usr/bin/perl
use strict;
use warnings;

# To Run:  ./final_proj.pl /software/Perl2/htaccess_1 through htaccess_5
# 1:  No order directive in input
# 2:  1.2.3.4 R, 1.2.3 A, 1.2.3.5 R, 1.2.3.6 A
# 3:  1.2.3.4 A, 1.2.3 R, 1.2.3.5 R
# 4:  mail.oreilly.com R, www.oreilly.com A, home.scott.oreilly.com R, boat.scott.oreilly.com R
# 5:  mail.oreilly.com R, 		     home.scott.oreilly.com A, boat.scott.oreilly.com A
my $Input_File;
my $orders;

if ( @ARGV == 0 )					## if not files entered, ask for one by STDIN
{
  print "Input FILE to be tested:  ";
  $_ = <STDIN>;
  chomp $_;
  exit if $_ =~ /quit/i;
  $ARGV[0] = $_;
}

my $n = @ARGV;
while ( @ARGV )						## loop over @ARGV and test each file 
{    
  $Input_File = shift;
   ## print "$Input_File\n";				## test for filename received			
  Get_Orders( $Input_File );	   				## call sub Test_File for each file on the command line
   ## print "Orders are: $orders\n";
  if ( $orders > 0 ) 
  { Get_Results( $Input_File, $orders ); }
   
  print "On to the next file...\n" if $n > 1; 
  $n--; 
}

sub Get_Orders
{
  $orders = 0;
  my $conflict = 0;

  open my $fh, '<', $Input_File or die "cannot open $Input_File:  $!";
  while ( my $line = <$fh> )
  {
    chomp $line;
    next if ($line eq "");
    my @checks = split(" ", $line);
    next unless $checks[0] eq "order";
    print "Multiple ORDER directives\n" if ( $checks[0] eq "order" && $conflict == 1 );
    
    if ( $checks[1] eq "allow,deny" )
    {
      $orders = 1;
      $conflict = 1;
    }
    if ( $checks[1] eq "deny,allow" )
    {
      $orders = 2;
      $conflict = 1;
    }      
  }
  close $fh;
  print "No order directive in input.\n" unless ( $orders > 0 );
      
  return $orders;
}

sub Get_Results
{
  print "Input address to test: ";
  while ( my $Test = <STDIN> )
  {  
    chomp $Test;
    return if $Test =~ /quit/i;
    my $accumulator = 0;
    my $allow = 0;					## set up defaults
    my $deny = 0;
    $orders == 1 ? $deny = 1 : $allow = 1;		## use orders to seed defaults
  
    open my $fh, '<', $Input_File or die "cannot open $Input_File:  $!";
    while ( my $line = <$fh> )
    {
      chomp $line;
      next if ($line eq "");
      return if $line =~ /quit/i;    
      my @data = split(" ", $line);
      next unless ( $data[0] eq "allow" || $data[0] eq "deny" );
      my $address = $data[2];          
      if ( $data[0] eq "allow" )
      { $allow = ( $orders * 5 ) if $Test =~ /$address/; }
      if ( $data[0] eq "deny" )
      { $deny = ( $orders * 5 ) if $Test =~ /$address/; }     
    }
    $accumulator = ( $allow + $deny );
    ## print "allow is: $allow and deny is: $deny and accumulator is $accumulator\n";
    if ( $orders == 1 )
    { ( $accumulator == 6 ) ? print "ALLOWED\n" : print "REJECTED\n"; }   
    if ( $orders == 2 )
    { ( $accumulator == 11 ) ? print "REJECTED\n" : print "ALLOWED\n"; } 
           
    close $fh;
    print "Input address to test: "; 
  }      
  return;
}

  