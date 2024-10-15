#!/usr/bin/env bash

set -ex

file_loc=~/code/fathom_api/bzlmod-registry/modules/gdal/3.9.1.gdalregistry.1/patches/add-build-files.patch

git diff v3.9.1 . ':!.github' ':!MODULE.bazel' ':!MODULE.bazel.lock' ':!.bazel*' > $file_loc

digest=$(openssl dgst -sha256 -binary $file_loc | openssl base64 -A | sed 's/^/sha256-/')


rundir=$(mktemp)
trap "rm -f ${rundir}" EXIT

patch_loc=~/code/fathom_api/bzlmod-registry/modules/gdal/3.9.1.gdalregistry.1/source.json
jq ".patches.\"add-build-files.patch\" = \"$digest\"" $patch_loc > $rundir

mv $rundir $patch_loc
