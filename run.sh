#!/bin/bash

helpFunction()
{
   echo ""
   echo "Usage: -o git.sqlite -r ../repo1 -r ../repo2"
   exit 1
}

while getopts o:r: opt; do
    case "$opt" in
        r) repos+=("$OPTARG");;
        o) out=$OPTARG;;
        ?) helpFunction
           break;;
    esac
done

if [ -z "$repos" ] || [ -z "$out" ]
then
   echo "Some or all of the parameters are empty";
   helpFunction
fi

SCRIPT="$PWD/metrics.awk"
CSV_BRIDGE=$(mktemp)

# hash | timestamp | author | subject
for repo in "${repos[@]}"; do
    (cd $repo; \
     git log --pretty="MARK%h|%aI|%aN|%s|" --shortstat | \
         tr '\n\  ' ' ' | \
         sed 's/MARK/\n/g' | \
         sed 's/"/\\"/g' | \
         grep '.' | \
         gawk -v service="$(basename $repo)" -f $SCRIPT) >> $CSV_BRIDGE
done

sqlite3 $out < schema.sql
sqlite3 $out ".import $CSV_BRIDGE stats"
sqlite3 $out -cmd ".mode table"
