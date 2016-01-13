#!/bin/bash

INFILE=raw-data.txt
BORTLIB_DATADIR=bort-data
source bortlib.sh

[[ -d $BORTLIB_DATADIR ]] || mkdata $INFILE

while read LINE; do
    linefromwords $LINE
done

