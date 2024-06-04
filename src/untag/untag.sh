#!/usr/bin/env bash

#
# Delete all local tags
#
git tag | xargs git tag -d

#
# Fetch to ensure we are up to date
#
git fetch

#
# Delete all remote tags
#
git tag | xargs git push origin --delete

#
# Re-delete all local tags
#
git tag | xargs git tag -d
