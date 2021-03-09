#!/bin/bash
## Usage: ./update_version.sh <version>

set -e
set -o pipefail

readonly NEW_VERSION=$1
if [ -z "$NEW_VERSION" ]; then
  echo "You must specify the new version!"
  exit 1
fi
readonly OLD_VERSION=$(grep -oP '(?<=^release \= ")\d+\.\d+\.\d+' docs/conf.py)

sed -i "s@$(echo "${OLD_VERSION}" | sed 's/\./\\./g')@$NEW_VERSION@g" docs/set_up_admin_tails.rst
sed -i "s@$(echo "${OLD_VERSION}" | sed 's/\./\\./g')@$NEW_VERSION@g" docs/backup_and_restore.rst
sed -i "s@$(echo "${OLD_VERSION}" | sed 's/\./\\./g')@$NEW_VERSION@g" docs/conf.py

echo "Versions updated. Verify the results with 'git diff' and be sure to tag"
echo "a new stable version as part of the release process."
