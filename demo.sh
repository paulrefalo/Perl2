#!/bin/sh
netstat | perl -nle 'print $1 if defined (/.+\s(.+):.+\Z/)';