#!/usr/bin/perl
use strict;
use warnings;



my $numargs=$#ARGV;
my @files;
my $dir = $ARGV[$#ARGV];
#my $regex=q"\D+\s\d{2}\,\s\d{4}";
my $regex=q"(\D+)\s(\d{1,2}),\s*(\d{2,4})";


if ( -d $dir )
{
$dir = substr ($ARGV[$#ARGV],0,16);
opendir(DIR, "$dir");
@files = grep(/\.pl/,readdir(DIR) );
closedir(DIR);			   
}
else
{
@files = $ARGV[$#ARGV];
}
 



foreach my $file (@files)
{
	search_for_dates($file);
}



my $in_month= shift;


my %months = (  	"jan" => "01", 
			"feb" => "02", 
			"mar" => "03", 
			"apr" => "04", 
			"may" => "05", 
			"jun" => "06", 
			"jul" => "07", 
			"aug" => "08", 
			"sep" => "09", 
			"oct" => "10", 
			"nov" => "11", 
			"dec" => "12") ;

my %fullmonths = ( 	"january" => "01", 
			"februry" => "02", 
			"march" => "03", 
			"april" => "04", 
			"may" => "05", 
			"june" => "06", 
			"july" => "07", 
			"august" => "08", 
			"september" => "09", 
			"october" => "10", 
			"november" => "11", 
			"december" => "12") ;

	if ( defined ($fullmonths{$in_month})  )
	{
		return ($fullmonths{$in_month}); 
	}
	elsif ( defined ($months{$in_month} )  )
	{
		return ($months{$in_month}); 
	}
	else
	{
		return -1;
	}

}

sub prnt_date
{
	my $cnv_date=shift;
	print "$cnv_date\n";
}


sub search_for_dates
{
	my $fname=shift;
        open my $fh,"<",$fname ;
        while ( $_ = <$fh> )
        {
                if ( $_ =~ /$regex/ ) 
		{ 	
			my $mth = $1  ; 	

			( month(lc $mth) != -1 ) &&  ( prnt_date( join("-",$3,month(lc $mth),$2 ) ) ) ;

		} 

        }
        close($fh);
}