#!/bin/bash
# changelog day by day
NEXT=$(date +%F)
echo "CHANGELOG"
echo ----------------------
git log --no-merges --format="%cd" --date=short | sort -u -r | while read DATE ; do
  echo
  echo [$DATE]
  GIT_PAGER=cat git log --no-merges --format="  %an %h %s" --since=$DATE --until=$NEXT
  NEXT=$DATE
done
