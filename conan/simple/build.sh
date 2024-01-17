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

conan install .. -pr default --settings=build_type=${BUILD_TYPE} --build=missing -s fmt:build_type=Release -s boost:build_type=Release
cmake ..
cmake --build . --config ${BUILD_TYPE}