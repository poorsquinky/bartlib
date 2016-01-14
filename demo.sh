#!/bin/bash

INFILE=raw-data.txt
BARTLIB_DATADIR=bart-data
source bartlib.sh

[[ -d $BARTLIB_DATADIR ]] || mkdata $INFILE

while read LINE; do
    linefromwords $LINE
done

