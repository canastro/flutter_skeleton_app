#!/usr/bin/env bash

# Runs `flutter test` on packages and the app
# Usage:
#    * sh scripts/test.sh app
#    * sh scripts/test.sh packages
#

function run_tests() {
  # Keep track if any of the tests failed without actually
  # stoping the following tests from executing
  exitCode=0

  if [ -d "test" ]
  then
   echo "Testing sub package $PWD"
    flutter test
  fi

  [ $? -eq 1 ] && exitCode=1

  if [ -d "packages" ]
  then
    cd packages || exit 1
    for d in ./*/ ; do
      (cd "$d" && run_tests);
      [ $? -eq 1 ] && exitCode=1
    done
    cd ..
  fi

  return $exitCode;
}

# go into the folder provided as first argument
cd $1 || exit

# if the given folder is a dart project, then run tests on the given package and sub-packages
# otherwiser iterate all folders and try to run tests on those packages and their sub-packages
if [ -f "pubspec.yaml" ]
then
    echo "Testing $1"
    run_tests
else
    exitCode=0
    for d in ./*/ ; do
      echo "Testing package $d"
      (cd "$d" && run_tests);
      [ $? -eq 1 ] && exitCode=1
    done
    exit $exitCode
fi
