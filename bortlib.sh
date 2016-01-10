#!/bin/bash

getwords() {
    (
        PREVWORD="$1"
        THISWORD="$2"
        CLEANWORD=$(cleantext "$THISWORD")
        FILENAME="${DATADIR}/${CLEANWORD}"
        if [[ -f $FILENAME ]]; then
            NEXTWORD=$(grep "^${PREVWORD} " "$FILENAME" | shuf | head -1 | awk '{ print $2 }')
            if [[ ! -z $NEXTWORD && $NEXTWORD != "__END" ]]; then
                echo -n " $NEXTWORD"
                getwords "$THISWORD" "$NEXTWORD"
            fi
        fi
    )
}

backwords() {
    (
        THISWORD="$1"
        NEXTWORD="$2"
        CLEANWORD=$(cleantext "$THISWORD")
        FILENAME="${DATADIR}/${CLEANWORD}"
        if [[ -f $FILENAME ]]; then
            PREVWORD=$(grep " ${NEXTWORD}$" "$FILENAME" | shuf | head -1 | awk '{ print $1 }')
            if [[ ! -z $PREVWORD && $PREVWORD != "__START" ]]; then
                backwords "$PREVWORD" "$THISWORD"
                echo -n "$PREVWORD "
            fi
        fi
    )
}

searchword() {
    SEARCHWORD=$1
    CLEANWORD=$(cleantext "$SEARCHWORD")
    FILENAME="${DATADIR}/${CLEANWORD}"
    if [[ -f $FILENAME ]]; then
        SEED=$(shuf "$FILENAME" | head -1)
        if [[ $( echo "$SEED" | wc -w ) == 2 ]]; then
            FIRSTWORD=$(echo "$SEED" | awk '{ print $1 }')
            LASTWORD=$(echo "$SEED" | awk '{ print $2 }')
            if [[ $FIRSTWORD != "__START" ]]; then
                backwords "$FIRSTWORD" "$SEARCHWORD"
                echo -n "$FIRSTWORD "
            fi
            echo -n "$SEARCHWORD"
            if [[ $LASTWORD != "__END" ]]; then
                echo -n " $LASTWORD"
                getwords "$SEARCHWORD" "$LASTWORD"
            fi
            echo
        fi
    fi
}

linefromwords() {
    IN=$(echo $@ | sed -E -e 's/  +/ /g')
    WC=$(echo $IN | wc -w)
    WORD=$(echo $IN | sed -E -e "s/([^ ]+ +){$(( RANDOM % WC ))}//" -e 's/ .*//')
    if [[ -z $WORD ]]; then
        randomline
    else
        searchword "$WORD"
    fi
}

randomline() {
    FIRSTWORD=$(shuf ${DATADIR}/__START | head -1 | awk '{ print $2 }')
    OUT="$FIRSTWORD"
    echo -n "$FIRSTWORD"
    getwords "__START" "$FIRSTWORD"
    echo
}

cleantext () {
    echo "$@" | tr A-Z a-z | sed -E -e 's/  +/ /g' -e "s/[^-=,'0-9a-z]//g"
}

mkdata() {
    mkdir -p "${DATADIR}"
    while read LINE; do
        WORD1=""
        WORD2=""
        WORD3=""
        for WORD in $LINE; do
            WORD1="$WORD2"
            WORD2="$WORD3"
            WORD3="$WORD"
            CLEANWORD=$(cleantext "$WORD2")
            if [[ -z $WORD2 || ! -z $CLEANWORD ]]; then
                WORDFILE="${DATADIR}/${CLEANWORD}"
                [[ -z $WORD2 ]] && WORDFILE="${DATADIR}/__START"
                if [[ -z $WORD1 ]]; then
                    echo "__START $WORD3" >> $WORDFILE
                else
                    echo "$WORD1 $WORD3" >> $WORDFILE
                fi
            fi
        done
        CLEANWORD=$(cleantext "$WORD3")
        [[ ! -z $CLEANWORD ]] && echo "$WORD2 __END" >> "${DATADIR}/${CLEANWORD}"
    done < <(sed -E -e 's/  +/ /' $1)
}

