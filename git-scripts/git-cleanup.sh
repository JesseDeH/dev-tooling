#!/bin/sh
set -e

git branch --merged | grep -v "\*\|main\|master\|develop\|sprint" | xargs -n 1 git branch -d