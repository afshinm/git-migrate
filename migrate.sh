#!/bin/bash

while IFS=: read reponame from to
do
    echo -e "Start migrating from \"$from\" ==> \"$to\""
    git clone "$from" "$reponame"
    cd "$reponame"
    for branch in `git branch -a | grep remotes | grep -v HEAD | grep -v master`; do
      git branch --track ${branch##*/} $branch
    done
    git remote add toRepo "$to"
    git push --all toRepo
    git push --tags toRepo
    cd ..
    rm -rf "$reponame"
    echo -e "Migration done."
done < ./CONFIG
