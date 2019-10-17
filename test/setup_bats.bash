#!/usr/bin/env bash

if [ -d libs/bats ] && [ -d libs/bats-assert ] && [ -d libs/bats-file ] && [ -d libs/bats-mock ] && [ -d libs/bats-support ]
then
  echo 'Previously setup by run'
else
  # Use --force to override the gitignore for test libs.
  git submodule add --force https://github.com/bats-core/bats-core.git test/libs/bats
  git submodule add --force https://github.com/jasonkarns/bats-assert-1.git test/libs/bats-assert
  git submodule add --force https://github.com/ztombol/bats-file.git test/libs/bats-file
  git submodule add --force https://github.com/jasonkarns/bats-mock.git test/libs/bats-mock
  git submodule add --force https://github.com/jasonkarns/bats-support.git test/libs/bats-support

  git submodule update --init --recursive --force

fi
