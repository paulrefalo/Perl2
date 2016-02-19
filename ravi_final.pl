#!/usr/bin/perl
use strict;
use warnings;

my $fData = {};
my $nOrder=0;

sub getDotElements
{
	my ($input,$rFlag) = @_;
	my @dotList = split('\.',$input);
	return (reverse(@dotList)) if (defined($rFlag));
	return @dotList;
}

#--------------------------------------------------------------
#sub searchByIP
#--------------------------------------------------------------
sub searchByIP
{
	my ($ip, $first, $second) = @_;
	my $len=0;
	my $diff=0;
	my @ipOcts = getDotElements($ip);
	my $matched = {};
	
	my $n = @ipOcts;

	for my $k3 ( sort {$fData->{LIST}->{IP}->{$first}->{$b}<=> $fData->{LIST}->{IP}->{$first}->{$a} } keys  %{$fData->{LIST}->{IP}->{$first}} ) {
                if ( $ip eq $k3 ) { # exact match, diff = 0
                        push ( @{$matched->{IP}->{0}->{$first}->{$ip}} , $k3 ) ;
		}
		elsif ( isThisIPMatched($ip, $k3, $diff) ) {
                        push ( @{$matched->{IP}->{$diff}->{$first}->{$ip}} , $k3 ) ;
                }
        }

	for my $k3 ( sort {$fData->{LIST}->{IP}->{$second}->{$b}<=> $fData->{LIST}->{IP}->{$second}->{$a} } keys  %{$fData->{LIST}->{IP}->{$second}} ) {
                if ( $ip eq $k3 ) { # exact match, diff = 0
                        push ( @{$matched->{IP}->{0}->{$second}->{$ip}} , $k3 ) ;
		}
		elsif ( isThisIPMatched($ip, $k3, $diff) ) {
                        push ( @{$matched->{IP}->{$diff}->{$second}->{$ip}} , $k3 ) ;
                }
        }

	# ---------- Decide whether to allow or deny -----------

	if ( $first eq "allow" ) {
                if ( defined($matched->{IP}->{0}->{allow}->{$ip})) {
                        print "ALLOWED \n";
                        return;
                }
                elsif (defined($matched->{IP}->{0}->{deny}->{$ip})) {
                        print "REJECTED\n";
                        return;
                }
                for my $l (1..$n) {
                        if (  defined($matched->{IP}->{$l}->{allow}->{$ip}) &&
				( @{$matched->{IP}->{$l}->{allow}->{$ip}} > 0 ))  {
                        	print "ALLOWED \n";
                                return;
                        }
                        elsif ( defined($matched->{IP}->{$l}->{deny}->{$ip}) &&
				(@{$matched->{IP}->{$l}->{deny}->{$ip}} > 0 )) {
                        	print "REJECTED\n";
                                return;
                        }
                }
        }
        elsif ( $first eq "deny" ) {
                if (defined($matched->{IP}->{0}->{allow}->{$ip})) { 
                        print "ALLOWED \n";
                        return;
                }
                elsif (defined($matched->{IP}->{0}->{deny}->{$ip})) { 
                        print "REJECTED \n";
                        return;
                }
                for my $l (1..$n) { # Deny if only matches with Deny
                        if ( defined($matched->{IP}->{$l}->{allow}->{$ip}) && 
				(@{$matched->{IP}->{$l}->{allow}->{$ip}} > 0 ))  {
                        	print "ALLOWED\n";
                                return;
                        }
                        elsif ( defined($matched->{IP}->{$l}->{deny}->{$ip})  &&
				( @{$matched->{IP}->{$l}->{deny}->{$ip}} > 0  )) {
                        	print "REJECTED\n";
                                return;
                        }
                }
                print "ALLOWED \n";
        }
}


#--------------------------------------------------------------
#sub searchByHostName
#--------------------------------------------------------------
sub searchByHostName
{
	my ($hname, $first, $second) = @_;
	my $len=0;
	my $diff=0;
	my @dList = getDotElements($hname, 1);
	my $matched = {};

	my $n = @dList;

	for my $k3 ( sort {$fData->{LIST}->{HOSTNAME}->{$first}->{$b}<=> $fData->{LIST}->{HOSTNAME}->{$first}->{$a} } keys  %{$fData->{LIST}->{HOSTNAME}->{$first}} ) {
                if ( $hname eq $k3 ) { # exact match, diff = 0
                        push ( @{$matched->{HOSTNAME}->{0}->{$first}->{$hname}} , $k3 ) ;
		}
		elsif ( isThisHostMatched($hname, $k3, $diff) ) {
                        push ( @{$matched->{HOSTNAME}->{$diff}->{$first}->{$hname}} , $k3 ) ;
                }
        }

	for my $k3 ( sort {$fData->{LIST}->{HOSTNAME}->{$second}->{$b}<=> $fData->{LIST}->{HOSTNAME}->{$second}->{$a} } keys  %{$fData->{LIST}->{HOSTNAME}->{$second}} ) {
                if ( $hname eq $k3 ) { # exact match, diff = 0
                        push ( @{$matched->{HOSTNAME}->{0}->{$second}->{$hname}} , $k3 ) ;
		}
		elsif ( isThisHostMatched($hname, $k3, $diff) ) {
                        push ( @{$matched->{HOSTNAME}->{$diff}->{$second}->{$hname}} , $k3 ) ;
                }
        }

	# ---------- Decide whether to allow or deny -----------

	if ( $first eq "allow" ) {
                if ( defined($matched->{HOSTNAME}->{0}->{allow}->{$hname})) {
                        print "ALLOWED\n";
                        return;
                }
                elsif (defined($matched->{HOSTNAME}->{0}->{deny}->{$hname})) {
                        print "REJECTED\n";
                        return;
                }
                for my $l (1..$n) {
                        if (  defined($matched->{HOSTNAME}->{$l}->{allow}->{$hname}) &&
				( @{$matched->{HOSTNAME}->{$l}->{allow}->{$hname}} > 0 ))  {
                                print "ALLOWED \n";
                                return;
                        }
                        elsif ( defined($matched->{HOSTNAME}->{$l}->{deny}->{$hname}) &&
				(@{$matched->{HOSTNAME}->{$l}->{deny}->{$hname}} > 0 )) {
                        	print "REJECTED\n";
                                return;
                        }
                }
        }
        elsif ( $first eq "deny" ) {
                if (defined($matched->{HOSTNAME}->{0}->{allow}->{$hname})) { 
                        print "ALLOWED \n";
                        return;
                }
                elsif (defined($matched->{HOSTNAME}->{0}->{deny}->{$hname})) { 
                        print "REJECTED\n";
                        return;
                }
                for my $l (1..$n) { # Deny if only matches with Deny
                        if ( defined($matched->{HOSTNAME}->{$l}->{allow}->{$hname}) && 
				(@{$matched->{HOSTNAME}->{$l}->{allow}->{$hname}} > 0 ))  {
                        	print "ALLOWED \n";
                                return;
                        }
                        elsif ( defined($matched->{HOSTNAME}->{$l}->{deny}->{$hname})  &&
				( @{$matched->{HOSTNAME}->{$l}->{deny}->{$hname}} > 0  )) {
                        	print "REJECTED\n";
                                return;
                        }
                }
                print "ALLOWED \n";
        }
}

sub isThisHostMatched
{
        my ($x1,$x2,$d) = @_;

        my @hL = getDotElements($x1,1);
        my @sL = getDotElements($x2,1);

        my $i = @hL;
        my $j = @sL;
        my $iters = 0 ;
        my $count = 0 ;

        if ( $j <  $i ) {
                $iters = $j;
        } else {
                 return 0;
        } # input hostname can not be matched as per the rules

        for my $k (0..$iters-1 ) {
                if ( $hL[$k] eq $sL[$k] )  {
                        $count++;
                }
                else {
                        if ( $count == 0 ) {
                                return 0;
                        }
                        else {
                                $_[2] = $i - $count;
                                return 0;
                        }
                }
        }
        $_[2] = $i - $count;
        return $count;
}

sub isThisIPMatched
{
        my ($x1,$x2,$d) = @_;

        my @hL = getDotElements($x1);
        my @sL = getDotElements($x2);

        my $i = @hL;
        my $j = @sL;
        my $iters = 0 ;
        my $count = 0 ;

        if ( $j <  $i ) {
                $iters = $j;
        } else {
                 return 0;
        } # input IP can not be matched as per the rules

        for my $k (0..$iters-1 ) {
                if ( $hL[$k] == $sL[$k] )  {
                        $count++;
                }
                else {
                        if ( $count == 0 ) {
                                return 0;
                        }
                        else {
                                $_[2] = $i - $count;
                                return 0;
                        }
                }
        }
        $_[2] = $i - $count;
        return $count;
}


#---------------- MAIN ------------------


while ( <> ) { 
	next if (/^#(.*)/);
        next if (/^[\s]+$/);
	chomp;

	if ( $_ =~ /^order\s+(allow,deny)|^order\s+(deny,allow)/ ) {
		my ($x1, $x2) = split;
		my ($x3,$x4) = split(",",$x2);
		$fData->{ORDER}->{RULE} ="$x3,$x4";
		$fData->{ORDER}->{FIRST}=$x3;
		$fData->{ORDER}->{SECOND}=$x4;
		$nOrder++;
	}	
	elsif ( $_ =~ /^allow\s+from\s+|^deny\s+from\s+/ ) {

		my ($x1, $x2, $x3) = split;
		$x3 =~ s/^\s+//;
		$x3 =~ s/\s+$//;
		if ( $x3 =~ /(^\d{1,3}\.?){1,4}/ ) {
			my @tmp = split('\.',$x3);
			my $nOcts = @tmp;
			if ( $x1 eq "allow" ) {
				delete $fData->{LIST}->{IP}->{deny}->{$x3} if (defined( $fData->{LIST}->{IP}->{deny}->{$x3}));
			}
			elsif ( $x1 eq "deny") {
				delete $fData->{LIST}->{IP}->{allow}->{$x3} if (defined( $fData->{LIST}->{IP}->{allow}->{$x3}));
			}
			$fData->{LIST}->{IP}->{$x1}->{$x3} = $nOcts;
		}
		else
		{
			my @tmp = split('\.',$x3);
			my $n = @tmp;
			if ( $x1 eq "allow" ) {
				delete $fData->{LIST}->{HOSTNAME}->{deny}->{$x3} if (defined( $fData->{LIST}->{HOSTNAME}->{deny}->{$x3}));
			}
			elsif ( $x1 eq "deny") {
				delete $fData->{LIST}->{HOSTNAME}->{allow}->{$x3} if (defined( $fData->{LIST}->{HOSTNAME}->{allow}->{$x3}));
			}
			$fData->{LIST}->{HOSTNAME}->{$x1}->{$x3} = $n;
		}	
	}

}
if ( $nOrder == 0 ) {
	die "No order directive in input\n";
}
elsif ( $nOrder > 1 ) {
	print "Warning: Multiple ORDER directives\n";
}

my $input;
print "Exter input hostname or IP: ";
$input = <STDIN>;
chomp($input);
while ( $input !~ /quit/i ) {
	chomp($input);
	#print "input = $input \n";
		if ( $input =~ /(^\d{1,3}\.?){1,4}/ ) {
			searchByIP($input, $fData->{ORDER}->{FIRST}, $fData->{ORDER}->{SECOND});
		}
		else
		{
			searchByHostName($input,$fData->{ORDER}->{FIRST}, $fData->{ORDER}->{SECOND});
		}

	print "Exter input hostname or IP: ";
	$input = <STDIN>;
	chomp($input);
}
