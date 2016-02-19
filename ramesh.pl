#!/usr/bin/perl
use strict;
use warnings;

my @option = @ARGV;
my $fileName = '/software/Perl2/regmatch.png';


#print @option;
#( defined($option[0])  =~ /regmatch/ ) && ( print_hex($fileName)) ;
if ( @ARGV == 0 ) { print_hex($fileName); }

(  ( ( defined($option[0] ) )  &&  ( $option[0] =~ /\-c/ ) ) ) &&  (nonprinthex($fileName));


sub print_hex
{
	my $flnm=shift;
	open FILE, $flnm or die "Couldn't open $fileName!";
	binmode FILE;
	my ( $buf,$data,$n);
	while (( $n = read FILE,$data, 16) !=0)
	{
		#my $name= unpack('H*',$data);
		printf ( " %02x ", ord($data)) ;
		$buf .= $data;
	}
	close FILE;
}



sub nonprinthex
{
	my $flnm=shift;
	open FILE, $flnm or die "Couldn't open $fileName!";
	binmode FILE;
	my ($buf,$data,$n);

	while (( $n = read FILE,$data, 1) !=0)
	{
		if ( 	$data =~ m/[^[:print:]]/g)
		{
			printf ( " %02x ", ord($data)) ;
		  	#print (unpack( "H*", $data ) ) ;
		}
		else 
		{
		  	print "$data";
		}
	}

close FILE;
}