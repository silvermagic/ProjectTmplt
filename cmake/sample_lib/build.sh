#!/bin/bash

rm -rf build
mkdir -p build
cd build || exit

BUILD_TYPE="Release"
for arg in "$@";do
  if [ "$arg" == "--debug" ];then
      BUILD_TYPE="Debug"
  fi
done

cmake .. -DCMAKE_BUILD_TYPE=$BUILD_TYPE
make
make install