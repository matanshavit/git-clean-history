#!/usr/bin/env bash

allFile="/tmp/git-clean-history-all.txt"
keepFile="/tmp/git-clean-history-keep.txt"
removeFile="/tmp/git-clean-history-remove.txt"

# Clean these files just incase
rm -f $allFile $keepFile $removeFile 2> /dev/null

# Get all files that ever existed
git log --pretty=format: --name-only --diff-filter=A | sort -u > $allFile

# Get all files we want to keep
git ls-tree -r $(git rev-parse --abbrev-ref HEAD) --name-only > $keepFile

# Get all the files we want to remove
comm -23 $allFile $keepFile > $removeFile

allFileCount=`wc -l $allFile`
keepFileCount=`wc -l $keepFile`

# Pull the file into a var, replacing newlines with spaces.
removeList=`cat $removeFile | tr '\n' ' '`

echo "Removing: $removeList"
git filter-branch -f --index-filter "git rm -r --cached ""$removeList"" --ignore-unmatch" --prune-empty --tag-name-filter cat -- --all
