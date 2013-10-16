#!/bin/bash

while IFS=: read reponame from to
do
    echo -e "Start migrating from \"$from\" ==> \"$to\""
    git clone "$from" "$reponame"
    cd "$reponame"
    git remote add toRepo "$to"
    git push --all toRepo
    cd ..
    rm -rf "$reponame"
    echo -e "Migration done."
done < ./CONFIG
