#!/bin/sh -e

# This script fetches the libgit2 sources for the requested version
# and synchronizes our third party directory with the required files.

# Tools
PAGER=${PAGER:-'/bin/less'}

SCRIPT_DIR=$(dirname `readlink -f -- $0`)
PROJECT_DIR="$SCRIPT_DIR/.."
WD="$PROJECT_DIR/libgit2"

REPO_URL='https://github.com/libgit2/libgit2.git'
TMP_CLONE_DIR='/tmp/libgit2-clone'
LG2_LICENSE_FILE="$TMP_CLONE_DIR/COPYING"
LG2_VERSION=$1

askContinue() {
  while true; do
  read -p "$1" yn
    case $yn in
        [Yy] ) rm -rf "$TMP_CLONE_DIR" ; break;;
        * ) echo 'Leaving, bye!'; exit 2;;
    esac
  done
}

syncWD() {
  from="$TMP_CLONE_DIR/$1"
  to="$WD/$2"

  echo "Sync'ing includes in workdir $from\t--> $to…"
  rsync -az --delete "$from" "$to"
}

if [ -z "$LG2_VERSION" ]; then
  echo "
Error: No libgit2 version was specified.
    Example: $0 v0.24.1

You can get a list of all available version with the follwing command:
    git ls-remote --tags $REPO_URL
"
  exit 1
fi

if [ -d "$TMP_CLONE_DIR" ]; then
  askContinue "The temporary directory $TMP_CLONE_DIR already exists. Sources are being fetched there. Overwrite [yN]?"
fi

echo "Cloning libgit2 sources from $REPO_URL…"
git clone --depth=2 --branch="$LG2_VERSION" -q https://github.com/libgit2/libgit2.git "$TMP_CLONE_DIR"

if [ -d "$WD" ]; then
  rm -rf "$WD"
fi
mkdir -p "$WD"

echo "Copying libgit2 license file $LG2_LICENSE_FILE"
cp $LG2_LICENSE_FILE $WD/.

syncWD 'src' ''
syncWD 'include' ''
syncWD 'deps' ''
