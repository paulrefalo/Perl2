#!/bin/sh
perl -nle '/(.*)/ and print $1' /etc/passwd