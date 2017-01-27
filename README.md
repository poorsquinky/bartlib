# bartlib
Markov-chain library written in Bash for some reason

## Usage
(from the `demo.sh` script)
```bash
#!/bin/bash

INFILE=raw-data.txt
BARTLIB_DATADIR=bart-data
source bartlib.sh

[[ -d $BARTLIB_DATADIR ]] || mkdata $INFILE

while read LINE; do
    linefromwords $LINE
done
```

### Commonly-used functions
* `mkdata FILENAME` - Create or add to the db directory (`$BARTLIB_DATADIR`) using the contents of the named file
* `store_line WORDS` - Store a single line of input into the db
* `linefromwords WORDS` - Generate some random output seeded by one of the given words at random
* `searchphrase WORDS` - Build output based on the phrase provided verbatim, not just one random word from it
* `randomline` - Generate a completely random line

