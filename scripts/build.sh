#!/usr/bin/env bash

# AVOID INVOKING THIS SCRIPT DIRECTLY -- USE `drake run build-<os>-<arch>`

set -euo pipefail

goos=$1
if [ "$goos" == "windows" ]; then
  file_ext=".exe"
else
  file_ext=""
fi

goarch=$2

source scripts/versioning.sh

base_package_name=github.com/lovethedrake/devdrake
ldflags="-w -X $base_package_name/pkg/version.version=$rel_version -X $base_package_name/pkg/version.commit=$git_version"

set -x

GOOS=$goos GOARCH=$goarch go build -ldflags "$ldflags" -o /shared/bin/drake/drake-$goos-$goarch$file_ext ./cmd/drake
