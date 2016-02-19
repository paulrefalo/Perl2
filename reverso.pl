#!/bin/sh
perl -le 'open($fh, +>) print scalar reverse for glob {[a-z][a-z]}'