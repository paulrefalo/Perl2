#!/bin/sh

netstat | perl -nle '/.*\s+(.*):.*\s+.*\b/ if(3..12) and print "$1"'