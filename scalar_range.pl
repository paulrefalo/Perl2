#!/usr/bin/perl
use strict;
use warnings;

while ( <DATA> )
{
  if ( /\A\Z/ .. /\A\.\Z/ )
  {
    print "Body line: $_";
  }
  else
  {
    print "Other line: $_";
  }
}

__END__
From: Peter Scott <peter@psdt.com>
To: Scott Gray <scott@oreilly.com>
Subject: Perl 2, Lesson 11

Hi Scott.  I just uploaded Lesson 11 of the
Intermediate Perl series.  The students are
really going to love the new one-liner capabilities!
.
Junk that's not part of the message...