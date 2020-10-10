#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Invalid argument number";
    exit 1;
fi;

for f in $(ls scripts/* | grep $1); do 
    sh $f;
done