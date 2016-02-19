#!/usr/bin/perl
use strict;
use warnings;

my @Beatles = qw(John Paul George Ringo);

my ($drummer, @vocals);
push @vocals, shift @Beatles; #take John and store it in vocals
push @vocals, shift @Beatles; #take Paul and store it in vocals
push @vocals, shift @Beatles; #take George and store it in vocals
$drummer = pop @Beatles; #Store Ringo in drummer
push @Beatles, 'Pete Best'; # add Pete Best at the end
push @Beatles, $drummer; #add Ringo at the end
shift @Beatles; #Remove Pete BEst
unshift @Beatles, @vocals; #Add names store in vocals

print "@Beatles\n";