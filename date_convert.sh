#!/bin/sh
cat some_dates.txt
perl -pi.bak -e 's/(\d\d*)\/(\d\d*)\/(\d\d\d\d)/$3-$1-$2/' some_dates.txt