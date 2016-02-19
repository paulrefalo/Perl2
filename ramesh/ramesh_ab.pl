#!/usr/bin/perl

my $name="aa";

my @removefiles;

create_files();

listcontentswithqQ();

removefileswithQq();

remainingfiles();


sub remainingfiles()
{
	opendir(DIR,"./");
	my @files = grep(/\D\D/,readdir(DIR) ) ;
	print "$#files : files with 2 charecters are Remaining\n";
}
sub removefileswithQq()
{
	my $filecount = unlink @removefiles;
	print "$filecount : Deleted \n";
}

sub listcontentswithqQ()
{
	opendir(DIR,"./");
	@removefiles=grep(/\A[Qq][A-z]/,readdir(DIR) );
	foreach  my $nm (@removefiles)
	{
		open $fh,"< $nm";
		while ($_=<$fh>)
		{
			print "$_\n";
		}
	}
}

sub create_files
{
	my $i;
	for($i=0;$i<676;++$i)
	{ 
		open (my $IN,"> $name");
		print  {$IN} uc $name;
		close($IN);
		$name=++$name;
	}
	print "$i: Files Created\n"
}