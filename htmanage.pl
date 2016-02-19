#!/usr/bin/perl
use strict;
use warnings;

my $Testing;
my $Input_File = '.htpasswd';
my $TEST_FILE = 'test.htpasswd';
my %Digest;

init( @ARGV );
$Testing and test() or run();

sub init
{
  my $read_filename;
  
  while ( @_ )
  {
    my $arg = shift;
    if ( $arg eq '-t' )
    {
      $Testing = 1;
    }
    elsif ( $arg eq '-f' )
    {
      $read_filename = 1;
    }
    elsif ( $read_filename )
    {
      $Input_File = $arg;
      $read_filename = 0;
    }
  }
}

sub run
{
  %Digest = parse_file( $Input_File );
  for ( menu(); my $command = <STDIN>; menu() )
  {
    chomp $command;
    act_on( $command );
  }
}

sub menu
{
  print "Entries in $Input_File:\n";
  my @options = make_options();
  for my $index ( 0 .. $#options )
  {
    printf "%2d %s\n", $index, $options[$index];
  }
  print "User or Option (0 - $#options)? ";
}

sub make_options
{
  my @options = 'Select to Quit';
  push @options, ( sort keys %Digest ), 'Select to Add New';
  return @options;
}

sub act_on
{
  my $command = shift;
  my @options = make_options();
  die "Invalid option" if $command !~ /\A\d+\z/ || ! $options[$command];
  exit if $options[$command] =~ /to Quit/i;
  if ( $options[$command] =~ /to Add/i )
  {
    ask_add();
  }
  else
  {
    do_change( $options[$command] );
  }
  write_file( $Input_File, %Digest );
}


sub ask_add
{
  print "Add (username): ";
  chomp (my $username = <STDIN>);
  print "    (password): ";
  chomp (my $password = <STDIN>);
  set( $username, $password );
}

sub set
{
  my ($username, $password) = @_;
  $Digest{$username} = crypt $password, create_salt();
}

sub create_salt
{
  my @chars = ('.', '/', 0..9, 'A'..'Z', 'a'..'z');
  return join '', $chars[rand @chars], $chars[rand @chars];
}

sub do_change
{
  my $username = shift;
  print "Change $username: (D)elete, (V)erify, (N)ew: ";
  chomp( my $cmd = <STDIN> );
  if ( $cmd =~ /\AN/i )
  {
    print "New password for $username: ";
    chomp( my $input = <STDIN> );
    set( $username, $input );
  }
  elsif ( $cmd =~ /\AD/i )
  {
    delete $Digest{$username};
  }
  elsif ( $cmd =~ /\AV/i )
  {
    print "Password to check: ";
    chomp( my $password = <STDIN> );
    print verify( $Digest{$username}, $password ) ? "Correct" : "Wrong", "\n";
  }
}


sub parse_file
{
  my $filename = shift;
  my %second_field;
  if ( open my $fh, '<', $filename )
  {
    while ( <$fh> )
    {
      chomp;
      my ($field1, $field2) = split /:/;
      $second_field{$field1} = $field2;
    }
  }
  return %second_field;
}

sub verify
{
  my ($digest, $password) = @_;
  return crypt( $password, $digest ) eq $digest;
}


sub test
{
  my %test_data = ( scott => '123', peter => '456', steve => '789' );
  write_file( $TEST_FILE, %test_data );
  my %test_data_read = parse_file( $TEST_FILE );
  for my $user ( keys %test_data )
  {
    delete $test_data_read{$user} or die "User $user not found";
  }
  keys %test_data_read and die "Spurious user(s) found in input";
  $Input_File = $TEST_FILE;
  set( $_, $test_data{$_} ) for keys %test_data;
  write_file( $Input_File, %Digest );
  %test_data_read = parse_file( $Input_File );
  verify( $test_data_read{$_}, $test_data{$_} )
    or die "Incorrect password for $_"
      for keys %test_data_read;
  
  unlink $TEST_FILE;
  print "Test pass\n";
}

sub write_file
{
  my ($filename, %data) = @_;
  open my $fh, '>', $filename or die "Couldn't open $filename for writing:  $!\n";
  print {$fh} "$_:$data{$_}\n" for keys %data;
}


  