#!/bin/bash

set -e
set -o pipefail

# Check for common errors in the documentation and exit 1 if any are found.
if grep -R --exclude-dir='_build' ansible_base docs/; then
  echo "Found reference to 'ansible_base' path name in the documentation."
  echo "The correct path name is 'ansible-base'."
  exit 1
fi

# Check for any HTTP links, except for those that are part of an onion address
# or those that are part of the SVG XML spec
if grep -R -I -n -P \
   'http://(?![^[:space:]]*(\.onion|xml))' \
   --exclude-dir='_build' \
   --exclude-dir='docs/diagrams' \
   --exclude='*.svg' \
   --exclude='conf.py' \
   --exclude='rebuild_admin.rst' \
   docs/; then
  echo "HTTP links found"
  exit 1
fi

echo "No common errors found."
exit 0
