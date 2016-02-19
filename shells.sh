#!/bin/sh
perl -nle '/.*:.*:.*:.*:.*:.*:(.*)/ and $h{$1}++; END{ print "$_: $h{$_}" foreach sort { $h{$b} <=> $h{$a} } keys %h }' /etc/passwd