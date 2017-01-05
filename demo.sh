#!/bin/bash

INFILE=raw-data.txt
BARTLIB_DATADIR=bart-data
source bartlib.sh

[[ -d $BARTLIB_DATADIR ]] || mkdata $INFILE

randomline

while read LINE; do
    OUT=$(linefromwords $LINE)
    [[ -z $OUT ]] && OUT=$(randomline)
    echo $OUT
done

