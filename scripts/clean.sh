#!/usr/bin/env bash

# Runs `pub get` on packages and the app
# Usage:
#    * sh scripts/clean.sh app
#    * sh scripts/clean.sh packages
#

function run_clean() {
  flutter pub get

  if [ -d "packages" ]
  then
    cd packages || exit 1
    for d in ./*/ ; do
      echo "Cleaning deps on sub package $d"
      (cd "$d" && run_clean);
    done
    cd ..
  fi
}

# go into the folder provided as first argument
cd $1 || exit

# if the given folder is a dart project, then run tests on the given package and sub-packages
# otherwiser iterate all folders and try to run tests on those packages and their sub-packages
if [ -f "pubspec.yaml" ]
then
    run_clean
else
    for d in ./*/ ; do
      echo "Cleaning deps on package $d"
      (cd "$d" && run_clean);
    done
fi
