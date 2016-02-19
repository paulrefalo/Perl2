#!/usr/bin/perl
use strict;
use warnings;

use Data::Dumper;

main();



sub main {
	my $variables = initialize_stuff(\@ARGV);
	
	process_stuff($variables);
	output($variables);
	exit_program();
}
	
	


sub initialize_stuff {
	my ( $files ) = @_;
	my %allows_denies = ();
	
	my %initialize = (
		files		=>	$files,
		allows_denies	=>	\%allows_denies,
		);
	
	return \%initialize;
}


sub check_denied {
	my ( $variables,$input,$status ) = @_;
	
	if ( $$variables{denies}{$input} ) {
		$status = 'REJECTED';
	}
	
	return $status;
}


sub check_allowed {
	my ( $variables,$input,$status ) = @_;
	
	if ( $$variables{allows}{$input} ) {
		$status = 'ALLOWED';
	}
	
	return $status;
}


sub process_stuff {
	my ($variables) = @_;
	
	my $files = $$variables{files};
	my $allows_denies = $$variables{allows_denies};
	
	$$allows_denies{directive} = assess_directive($files);
	
	if ( $$allows_denies{directive} eq 'allow_deny' ) {
		$allows_denies = allow_deny($files,$allows_denies);
	}
	elsif ( $$allows_denies{directive} eq 'deny_allow' ) {
		$allows_denies = deny_allow($files,$allows_denies);
	}
}


sub assess_directive {
	my ( $files ) = @_;
	my $directive = 0;
	
	my $count = 1;
	foreach my $file (@$files) {
		open my $fh, '<', $file or die "Can't open $file: $!\n";
		while (<$fh>) {
			my $line = $_;
			chomp $line;
			if ( $line =~ /allow,deny\z/ && $count == 1 ) {	
				if ( $directive eq 'deny_allow' ) {
					print "Warning: there is more than one order directive\n";
					print "And the final one - allow,deny - is taken\n";
				}
				$directive = 'allow_deny';
				
			}
			elsif ( $line =~ /deny,allow\z/ && $count == 1) {
				if ( $directive eq 'allow_deny' ) {
					print "Warning: there is more than one order directive\n";
					print "And the final one - deny,allow - is taken\n";
				}
				$directive = 'deny_allow';
			}
			elsif ( $line =~ /allow,deny\z/ && $count > 1 ) {
				print "ERROR: There is a directive after the first file\n";
				exit_program();
			}
			elsif ( $line =~ /deny,allow\z/ && $count > 1 ) {
				print "ERROR: There is a directive after the first file\n";
				exit_program();
			}
			
		}
		close $fh;
		++$count;
	}
	unless ($directive) {
		print "ERROR: there is no directive line in the first file\n";
		exit_program();
	}
	return $directive;
}


sub allow_deny {
	my ( $files, $variables ) = @_;
	my %allows = ();
	my %denies = ();
	my @foo;
	
	my $test_input = 444;
	
	foreach my $file (@$files) {
		open my $fh, '<', $file or die "Can't open $file: $!\n";
		while (<$fh>) {
			my $line = $_;
			chomp $line;
		
			if ( $line =~ /\Adeny/ ) {
				@foo = split(/\s+/,$line);
				$test_input = test_input($foo[2]);
				$denies{$foo[2]}++;
			}
			if ( $line =~ /\Aallow/ ) {
				@foo = split(/\s+/,$line);
				$test_input = test_input($foo[2]);
				$allows{$foo[2]}++;
			}
		}
		close ($fh);
	}
	
	foreach my $item ( keys %allows ) {
		unless ( $denies{$item} ) {
			$$variables{allows}{$item}++;
		}
	}
	foreach my $item ( keys %denies ) {
		$$variables{denies}{$item}++;
	}
			
	output($variables);
	
	interact_allow_deny($variables);
}


sub deny_allow {
	my ( $files, $variables ) = @_;
	my %allows = ();
	my %denies = ();
	my @foo;
	
	my $test_input = 444;
	
	foreach my $file (@$files) {
		open my $fh, '<', $file or die "Can't open $file: $!\n";
		while (<$fh>) {
			my $line = $_;
			chomp $line;
		
			if ( $line =~ /\Adeny/ ) {
				@foo = split(/\s+/,$line);
				$test_input = test_input($foo[2]);
				$denies{$foo[2]}++;
			}
			if ( $line =~ /\Aallow/ ) {
				@foo = split(/\s+/,$line);
				$test_input = test_input($foo[2]);
				$allows{$foo[2]}++;
			}
		}
		close ($fh);
	}
	
	foreach my $item ( keys %denies ) {
		unless ( $allows{$item} ) {
			$$variables{denies}{$item}++;
		}
	}
	foreach my $item ( keys %allows ) {
		$$variables{allows}{$item}++;
	}
			
	output($variables);
	interact_deny_allow($variables);
}


sub interact_allow_deny {
	my ( $variables ) = @_;
	
	print "Enter address to test: ";
	my $input = <STDIN>;
	chomp $input;
	
	if ( $input eq 'quit' ) {
		exit_program();
	}
	
	my $test_result = test_input($input);
	if ( $test_result =~ /\Aip/ ) {
		assess_allow_deny_ip( $input, $test_result, $variables);
	}
	elsif ( $test_result =~ /\Ahost/ ) {
		assess_allow_deny_host( $input, $test_result, $variables);
	}
	else {
		print "INVALID ENTRY: $input\n\n";
		interact_allow_deny( $variables );
	}
}



sub interact_deny_allow {
	my ( $variables ) = @_;
	
	print "Enter address to test: ";
	my $input = <STDIN>;
	chomp $input;
	
	if ( $input eq 'quit' ) {
		exit_program();
	}
	
	my $test_result = test_input($input);
	if ( $test_result =~ /\Aip/ ) {
		assess_deny_allow_ip( $input, $test_result, $variables);
	}
	elsif ( $test_result =~ /\Ahost/ ) {
		assess_deny_allow_host( $input, $test_result, $variables);
	}
	else {
		print "INVALID ENTRY: $input\n\n";
		interact_deny_allow( $variables );
	}
}




sub assess_allow_deny_ip {
	my ( $input, $test_result, $variables) = @_;
	
	if ( $input eq 'quit' ) {
		exit_program();
	}
	else {
		my $status = 'open';
		my $test_result = test_input($input);
		if ( $test_result eq 'ip_4' ) {
			$status = check_denied($variables,$input,$status);
			if ( $status ne 'REJECTED' ) {
				$status = check_allowed($variables,$input,$status);
				if ( $status ne 'ALLOWED' ) {
					# remove last digit and test FOR 3 DIGITS
					my @foo = split(/\./,$input);
					my $input_3 = "$foo[0]\.$foo[1]\.$foo[2]";
					$status = determine_status_allow_deny($variables,$input_3);
				}
			}
		}
		elsif ( $test_result eq 'ip_3' ) {
			$status = determine_status_allow_deny($variables,$input);
		}
		else {
			$status = "INVALID ENTRY: $input\n\n";
		}
		print "$status\n\n";
		interact_allow_deny($variables);
	}
}


sub assess_allow_deny_host {
	my ( $input, $test_result, $variables) = @_;
	
	if ( $input eq 'quit' ) {
		exit_program();
	}
	else {
		my $status = 'open';
		my $test_result = test_input($input);
		if ( $test_result eq 'host_4' ) {
			$status = check_denied($variables,$input,$status);
			if ( $status ne 'REJECTED' ) {
				$status = check_allowed($variables,$input,$status);
				if ( $status ne 'ALLOWED' ) {
					# remove first portion and test FOR 3 PORTIONS
					my @foo = split(/\./,$input);
					my $input_3 = "$foo[1]\.$foo[2]\.$foo[3]";
					$status = check_denied($variables,$input_3,$status);
					if ( $status ne 'REJECTED' ) {
						$status = check_allowed($variables,$input_3,$status);
						if ( $status ne 'ALLOWED' ) {
							# remove first portion and test FOR 3 PORTIONS
							my @foo = split(/\./,$input);
							my $input_2 = "$foo[1]\.$foo[2]";
							$status = determine_status_allow_deny($variables,$input_2);
						}
					}
				}
			}
		}
		elsif ( $test_result eq 'host_3' ) {
			$status = check_allowed($variables,$input,$status);
				if ( $status ne 'ALLOWED' ) {
					$status = check_denied($variables,$input,$status);
					if ( $status ne 'REJECTED' ) {
						# remove first portion and test FOR 2 PORTIONS
						my @foo = split(/\./,$input);
						my $input_2 = "$foo[1]\.$foo[2]";
						$status = determine_status_allow_deny($variables,$input_2);
					}
				}
		}
		elsif ( $test_result eq 'host_2' ) {
			$status = determine_status_allow_deny($variables,$input);
		}
		else {
			$status = "INVALID ENTRY: $input\n\n";
		}
		print "$status\n\n";
		interact_allow_deny($variables);
	}
	exit_program();		
}


sub assess_deny_allow_ip {
	my ( $input, $test_result, $variables) = @_;
	
	if ( $input eq 'quit' ) {
		exit_program();
	}
	else {
		my $test_result = test_input($input);
		my $status = 'open';
		if ( $test_result eq 'ip_4' ) {
			$status = check_allowed($variables,$input,$status);
			if ( $status ne 'ALLOWED' ) {
				$status = check_denied($variables,$input,$status);
				if ( $status ne 'REJECTED' ) {
					# remove last digit and test FOR 3 DIGITS
					my @foo = split(/\./,$input);
					my $input_3 = "$foo[0]\.$foo[1]\.$foo[2]";
					$status = determine_status_deny_allow($variables,$input_3);
				}
			}
		}
		elsif ( $test_result eq 'ip_3' ) {
			$status = determine_status_deny_allow($variables,$input);
		}
		else {
			$status = "L306 - INVALID ENTRY: $input\n\n";
		}
		print "$status\n\n";
		interact_deny_allow($variables);
	}
	exit_program();		
}



sub assess_deny_allow_host {
	my ( $input, $test_result, $variables) = @_;
	
	if ( $input eq 'quit' ) {
		exit_program();
	}
	else {
		my $test_result = test_input($input);
		my $status = 'open';
		if ( $test_result eq 'host_4' ) {
			$status = check_allowed($variables,$input,$status);
			if ( $status ne 'ALLOWED' ) {
				$status = check_denied($variables,$input,$status);
				if ( $status ne 'REJECTED' ) {
					# remove first portion and test FOR 3 PORTIONS
					my @foo = split(/\./,$input);
					my $input_3 = "$foo[1]\.$foo[2]\.$foo[3]";
					$status = check_allowed($variables,$input_3,$status);
					if ( $status ne 'ALLOWED' ) {
						$status = check_denied($variables,$input_3,$status);
						if ( $status ne 'REJECTED' ) {
							# remove first portion and test FOR 3 PORTIONS
							my @foo = split(/\./,$input);
							my $input_2 = "$foo[1]\.$foo[2]";
							$status = determine_status_deny_allow($variables,$input_2);
						}
					}
				}
			}
		}
		elsif ( $test_result eq 'host_3' ) {
			$status = check_allowed($variables,$input,$status);
				if ( $status ne 'ALLOWED' ) {
					$status = check_denied($variables,$input,$status);
					if ( $status ne 'REJECTED' ) {
						# remove first portion and test FOR 2 PORTIONS
						my @foo = split(/\./,$input);
						my $input_2 = "$foo[1]\.$foo[2]";
						$status = determine_status_deny_allow($variables,$input_2);
					}
				}
		}
		elsif ( $test_result eq 'host_2' ) {
			$status = determine_status_deny_allow($variables,$input);
		}
		else {
			$status = "INVALID ENTRY: $input\n\n";
		}
		print "$status\n\n";
		interact_deny_allow($variables);
	}
	exit_program();		
}



sub test_input {
	my ( $input ) = @_;
	
	my $test_result = (
	($input =~ /\A\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\Z/) 	? 'ip_4'   :
	($input =~ /\A\d{1,3}\.\d{1,3}\.\d{1,3}\Z/) 		? 'ip_3'   :
	($input =~ /\A\w+\.\w+\.\w+\.\w+\Z/) 			? 'host_4' :
	($input =~ /\A\w+\.\w+\.\w+\Z/) 			? 'host_3' :
	($input =~ /\A\w+\.\w+\Z/) 				? 'host_2' :
	666 );

	return $test_result;
}



sub determine_status_deny_allow {
	my ( $variables, $input ) = @_;
	
	chomp $input;
	my $status;

	if ( $$variables{denies}{$input} ) {
		$status = 'REJECTED';
	}
	else {
		$status = 'ALLOWED';
	}
	
	return $status;
}



sub determine_status_allow_deny {
	my ( $variables, $input ) = @_;
	
	chomp $input;
	my $status;

	if ( $$variables{allows}{$input} ) {
		$status = 'ALLOWED';
	}
	else {
		$status = 'REJECTED';
	}
	
	return $status;
}



sub output {
	my ($variables) = @_;
	
	print 'OUTPUT: ', Dumper(%$variables);
}



sub exit_program {
	print "Program exiting\n";
	exit;
}
		