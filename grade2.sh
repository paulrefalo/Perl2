#!/bin/sh
cat some_dates.txt | perl -pi.bak -e 's|(\d\d)/(\d\d)/(\d\d\d\d)|$3-$2-$1|' some_dates.txt