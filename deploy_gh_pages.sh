#!/bin/bash

git checkout --orphan gh-pages-temp
yarn build

# Delete all contents except `/dist`
shopt -s extglob dotglob
mv !(to_del|dist) to_del
shopt -u dotglob
rm -rf to_del

# Place `/dist`files where GitHub pages will see them.
mv dist/* .
rm -rf dist

# Deploy and return
git add .
git commit -m "Deploy to GitHub pages"
git push origin HEAD:gh-pages --force
git checkout main
git branch -D gh-pages-temp
