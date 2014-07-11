#!/usr/bin/env bash

for dir in *
do
    if [[ ! -d $dir ]]
    then
        continue
    fi
    echo $dir && \
    cd $dir && \
    git fast-import < ../$dir.fi && \
    cd .. \
    || break
done