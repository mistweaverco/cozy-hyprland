#!/usr/bin/env bash

if [ -z "$VERSION" ]; then echo "Error: VERSION is not set"; exit 1; fi

GH_TAG="v$VERSION"

do_gh_release() {
  echo "Creating new release $GH_TAG"
  gh release create --generate-notes "$GH_TAG" || echo "Release already exists.." && exit 0;
}

release() {
  do_gh_release
}

release
