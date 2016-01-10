#!/bin/bash

INFILE=raw-data.txt
DATADIR=bort-data
source bortlib.sh

[[ -d $DATADIR ]] || mkdata $INFILE

while read LINE; do
    linefromwords $LINE
done

