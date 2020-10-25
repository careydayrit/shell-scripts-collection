#!/bin/bash

CURRENT_DIR=$(dirname "$0")
cd $CURRENT_DIR
echo "monthly commit $(date)" >> monthly-commit.txt
git add ./
git commit -am "monthly commit $(date)" 
git push
