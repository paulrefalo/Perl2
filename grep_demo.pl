#!/usr/bin/perl
use strict;
use warnings;

my $text = <<"END_OF_TEXT";
Love, love me do.
You know I love you,
Ill always be true,
So please, love me do.
Whoa, love me do.

Love, love me do.
You know I love you,
Ill always be true,
So please, love me do.
Whoa, love me do.

Someone to love,
Somebody new.
Someone to love,
Someone like you.

Love, love me do.
You know I love you,
Ill always be true,
So please, love me do.
Whoa, love me do.

Love love me do.
You know I love you,
Ill always be true,
So please, love me do.
Whoa, love-me do.
Yeah, love,me do. 
Whoa, oh, love me do
END_OF_TEXT


my (@words) = split " ", lc $text;
my %count;
for my $word ( @words ) {
$count{$word}++ ;
}

foreach my $atom ( sort keys %count ) {
  print "$atom\n";
}
print "\nFor hash \%count:  ", scalar keys %count, "\n";
print "\n";
print '*'x88;
print "\n";
my %test = grep { /\A[a-z]+\z/ } @words;

foreach my $grep_words ( sort keys %test ) {
  print "$grep_words\n";
}
print "\nFor hash \%test:  ", scalar keys %test, "\n";
print "\n";
#print "'love' occurs $count{love} times\n";


__END__
cat
dog