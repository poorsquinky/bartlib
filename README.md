# bortlib
Markov-chain library written in Bash for some reason

## Usage
(from the `demo.sh` script)
```bash
#!/bin/bash

INFILE=raw-data.txt
BORTLIB_DATADIR=bort-data
source bortlib.sh

[[ -d $BORTLIB_DATADIR ]] || mkdata $INFILE

while read LINE; do
    linefromwords $LINE
done
```

### Commonly-used functions
* `mkdata FILENAME` - Create or add to the db directory (`$BORTLIB_DATADIR`) using the contents of the named file
* `store_line WORDS` - Store a single line of input into the db
* `linefromwords WORDS` - Generate some random output seeded by some words
* `randomline` - Generate a completely random line

