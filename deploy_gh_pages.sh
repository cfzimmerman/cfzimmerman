#!/bin/bash

# Reorganize the code in a temporary branch before pushing
rm -r dist &&
	git checkout --orphan gh-pages-temp &&
	yarn build &&

	# Reorganize files so that only .git and the contents of dist remain
	mkdir to_del &&
	find . -maxdepth 1 ! -name . ! -name .git ! -name dist ! -name to_del -exec mv {} to_del \; &&
	mv dist/* . &&
	rm -rf dist to_del &&

	# Deploy
	git add . &&
	git commit -m "Deploy to GitHub pages" &&
	git push origin HEAD:gh-pages --force &&

	# Clean up
	git checkout main &&
	git branch -D gh-pages-temp
