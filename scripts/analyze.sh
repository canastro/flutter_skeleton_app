#!/usr/bin/env bash

# Runs `analyze` on packages and the app
# Usage:
#    * sh scripts/analyze.sh app
#    * sh scripts/analyze.sh packages
#

function run_analyze() {
  # Keep track if any of the tests failed without actually
  # stoping the following tests from executing
  exitCode=0

  flutter analyze .
  [ $? -eq 1 ] && exitCode=1

  if [ -d "packages" ]
  then
    cd packages || exit 1
    for d in ./*/ ; do
      echo "Analyzing sub package $d"
      (cd "$d" && run_analyze);
      [ $? -eq 1 ] && exitCode=1
    done
    cd ..
  fi

  return $exitCode;
}

# go into the folder provided as first argument
cd $1 || exit 1

# if the given folder is a dart project, then run tests on the given package and sub-packages
# otherwiser iterate all folders and try to run tests on those packages and their sub-packages
if [ -f "pubspec.yaml" ]
then
    echo "Analyzing $1"
    run_analyze
else
    exitCode=0
    for d in ./*/ ; do
      echo "Analyzing package $d"
      (cd "$d" && run_analyze);
      [ $? -eq 1 ] && exitCode=1
    done
    exit $exitCode
fi
