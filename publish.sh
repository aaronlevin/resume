#!/usr/bin/env bash

# grab the name of the current branch
current_branch() {
  git rev-parse --abbrev-ref HEAD
}

main() {

  local branch=$(current_branch)

  git stash
  git checkout gh-pages
  git merge origin/master
  cp resume.html index.html
  git add index.html
  git commit -m "publish resume"
  git push origin gh-pages
  git checkout "${branch}"
  git stash pop
}

main $@
