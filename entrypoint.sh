#!/bin/sh -l

echo "Hello $1"
time=$(date)
echo "time=$time" >> $GITHUB_OUTPUT

cd /github/workspace || exit
echo Listing files in workspace
ls -al