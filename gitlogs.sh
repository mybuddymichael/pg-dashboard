#!/bin/sh
for branch in $(git for-each-ref --format='%(refname:short)' refs/heads/); do                                                                                                   
  temp=`git log $branch --pretty=format:"{\"branch\":\"${branch}\",\"commit\":\"%H\",\"author\":\"%an\",\"email\":\"%ae\",\"date\":\"%ad\",\"message\":\"%s\"}" --max-count=1`
  curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST -d "${temp}" http://127.0.0.1:3000/update_git
done
