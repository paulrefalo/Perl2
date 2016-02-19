#!/usr/bin/perl
use strict;
use warnings;

my $Input_File;
my $orders;


init( @ARGV );						## parse out input file(s) for testing


sub init						## read file(s) in and call sub Test_File for each
{
  if ( @ARGV == 0 )					## if not files entered, ask for one by STDIN
  {
    print "Input FILE to be tested:  ";
    $Input_File = <STDIN>;
    chomp $Input_File;
    exit if $Input_File =~ /quit/i;
    Get_Orders( $Input_File );	   			## call sub Get_Orders for each file on the command line
    
    if ( $orders == 1 )
    {
      allow_deny( $Input_File );
    }
    if ($orders == 2 )
    {
      deny_allow( $Input_File );
    }
  }
    
  my $n = @_; 
  
  while ( @_ )						## loop over @_ and test each file 
  {    
    $Input_File = shift;
    ## print "$Input_File\n";				## test for filename received			
    Get_Orders( $Input_File );	   			## call sub Test_File for each file on the command line
    ## print "Orders are: $orders\n";
    if ( $orders == 1 )
    {
      allow_deny( $Input_File );
    }
    if ($orders == 2 )
    {
      deny_allow( $Input_File );
    }  
    print "On to the next file...\n" if $n > 1; 
    $n--; 
  }
  return;
}



sub Get_Orders
{
  $orders = 0;
  my $conflict = 0;
  open my $fh, '<', $Input_File or die "cannot open $Input_File:  $!";
  my $line = <$fh>;
  chomp $line;
  my @info = split(" ", $line);
  
  unless ( $info[0] eq "order" )
  { die "No order directive in input.\n"; }
  unless ( $info[1] eq "allow,deny" || $info[1] eq "deny,allow" )
  {
    warn "Your papers are not in order.\n";
    $orders = 0;
    return $orders;
  }
  
  if ( $info[1] eq "allow,deny" )
  {
    $orders = 1;
    $conflict = 1;
  }
  
  if ( $info[1] eq "deny,allow" )
  {
    $orders = 2;
    $conflict = 1;
  }
  
  while ( my $line = <$fh> )
  {
    chomp $line;
    next if ($line eq "");
    my @checks = split(" ", $line);
    if ( $checks[0] eq "order" && $conflict == 1 )
    {
      print "Multiple ORDER directives\n";
      if ( $checks[1] eq "allow,deny" )
      { $orders = 1; }
  
      if ( $checks[1] eq "deny,allow" )
      { $orders = 2; }
      next;
    }
      
    ## print "$line\n";
  }
  close $fh;
  return $orders;
}

sub allow_deny
{
  my $result = 1;
  print "Input address to test: ";
  while ( my $Test = <STDIN> )
  {  
    chomp $Test;
    return if $Test =~ /quit/i;
  
    open my $fh, '<', $Input_File or die "cannot open $Input_File:  $!";
    while ( my $line = <$fh> )
    {
      chomp $line;
      next if ($line eq "");
      return if $line =~ /quit/i;
    
      my @data = split(" ", $line);
      next if $data[0] eq "order";
      next unless ( $data[0] eq "allow" || $data[0] eq "deny" );
      my $address = $data[2];

    
      if ( $data[0] eq "allow" )
      {
         if ( $Test =~ /$address/ )
         { $result = 2; }
      }    
    ## print "Address is: $address\n";      
    }
    close $fh;
    
    open $fh, '<', $Input_File or die "cannot open $Input_File:  $!";
    while ( my $line = <$fh> )
    {
      chomp $line;
      next if ($line eq "");
      return if $line =~ /quit/i;
    
      my @data = split(" ", $line);
      next if $data[0] eq "order";
      next unless ( $data[0] eq "allow" || $data[0] eq "deny" );
      my $address = $data[2];

    
      if ( $data[0] eq "deny" )
      {
         if ( $Test =~ /$address/ )
         { $result = 1; }
      }         
    }
    close $fh;
  
    ## print "Test is: $Test\n";
    if ( $result == 1 )
    { print "REJECTED\n"; }
  
    if ( $result == 2 )
    { print "ALLOWED\n"; }
    
    $result = 1;
    print "Input address to test: ";
  }
  
  return;
}

sub deny_allow
{
  my $result = 2;
  print "Input address to test: ";
  while ( my $Test = <STDIN> )
  {  
    chomp $Test;
    return if $Test =~ /quit/i;
  
    open my $fh, '<', $Input_File or die "cannot open $Input_File:  $!";
    while ( my $line = <$fh> )
    {
      chomp $line;
      next if ($line eq "");
      return if $line =~ /quit/i;   
      my @data = split(" ", $line);
      next if $data[0] eq "order";
      next unless ( $data[0] eq "allow" || $data[0] eq "deny" );
      
      my $address = $data[2];

      if ( $data[0] eq "deny" )
      {
        if ( $Test =~ /$address/ )
        { $result = 1 }
      }  
      
    ## print "Address is: $address\n";     
    }
    close $fh;
    

    open $fh, '<', $Input_File or die "cannot open $Input_File:  $!";
    while ( my $line = <$fh> )
    {
      chomp $line;
      next if ($line eq "");
      return if $line =~ /quit/i;   
      my @data = split(" ", $line);
      next if $data[0] eq "order";
      next unless ( $data[0] eq "allow" || $data[0] eq "deny" );
      
      my $address = $data[2];

      if ( $data[0] eq "allow" )
      {
         if ( $Test =~ /$address/ )
         { $result = 2; }
      }    
    
    }
    close $fh;
    
    ## print "Test is: $Test\n";
    if ( $result == 1 )
    { print "REJECTED\n"; }
  
    if ( $result == 2 )
    { print "ALLOWED\n"; }
    
    $result = 2;
    print "Input address to test: ";
  }
  
  return;
}
  
  
  
    
    
  
  
  