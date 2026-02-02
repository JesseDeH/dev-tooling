#!/bin/bash

curr=$(git rev-parse --abbrev-ref HEAD)
if [ "$curr" = "HEAD" ]; then
    echo "Not on a branch." >&2
    exit 1
elif [[ "$curr" =~ ^(main|master|develop|sprint)$ ]]; then
    echo "Cannot merge from protected branch: $curr" >&2
    exit 1
fi

git switch sprint
git pull
git merge $curr
git push
git switch $curr

exit 0