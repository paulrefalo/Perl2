#!/usr/bin/perl
use strict;
use warnings;

sub regex_from_address
{
    my $input = shift;    
    my $atoms = join('\.', split('\.', $input));
    return $input =~ /\A(?:[\d]\.?)+\z/ ? '\A' . $atoms : $atoms . '\z';
}

sub extract_derectives
{   
    my ($address, $directive, @lines) = (shift, shift, @_);
    
    my $match;
    for my $line (@lines){
        if ($line =~ /((?:allow|deny)) from (.*)/ && $1 eq $directive ){
            my ($target_directive, $target_address ) = ($1, $2);
            
            my $regex = regex_from_address $target_address;
            if ( $address =~ /$regex/){
                $match = $target_directive;
            }
        }
    }
    return $match;
}

sub extract_orders
{
    my @lines = @_;
    my @orders;
    
    for my $line ( @lines ){
        if ($line =~ /order ((?:allow|deny)),((?:allow|deny))/){
            $1 ne $2 ? push @orders, $1 : warn "Invalid directives given\n";
        } 
    }
    
    if ( ! defined $orders[0] ){
         die "No order directive in input\n";
    } elsif ( $#orders > 0 ){
         warn "Multiple ORDER directives\n";
    }
    
    return $orders[-1];
}

sub extract_result
{
    my ($filename, $address, $a_directive, @lines) = (shift, shift, shift, @_);

    my $b_directive = $a_directive eq 'allow' ? 'deny' : 'allow';
    my $a_result = extract_derectives $address, $a_directive, @lines;
    my $b_result = extract_derectives $address, $b_directive, @lines;
    
    my $result;
    if (defined $a_result){
        $result = defined $b_result ? $b_result : $a_result;
    } elsif (defined $b_result){
        $result = $b_result;
    } else {
        $result = $a_directive;
    }

    return $result;
}

sub run 
{
    @ARGV == 1 ?  my $filename = shift @ARGV : die "Filename not specified\n";
    
    open my $fh, '<', $filename or die "Can not open $filename $!\n";
    chomp( my @lines = <$fh> );
    
    my $order  = extract_orders @lines;
    for ( print_prompt(); chomp( my $address = <STDIN>); print_prompt() ){
        last if $address =~ /\A(?:quit|q)\z/i;
        my $result = extract_result $filename, $address, $order, @lines;
        print "\n", $result eq 'allow' ? 'ALLOWED' : 'REJECTED', "\n\n";
    }
}

sub print_prompt{ print "Input address to test: "}

run();