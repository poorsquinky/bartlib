# bortlib
Markov-chain library written in Bash for some reason

## Usage
(from the `demo.sh` script)
```bash
#!/bin/bash

INFILE=raw-data.txt
DATADIR=bort-data
source bortlib.sh

[[ -d $DATADIR ]] || mkdata $INFILE

while read LINE; do
    linefromwords $LINE
done
```

### Commonly-used functions
* `mkdata FILENAME` - Create or add to the db directory (`$DATADIR`) using the contents of the named file
* `linefromwords WORDS` - Generate some random output seeded by some words
* `randomline` - Generate a completely random line

