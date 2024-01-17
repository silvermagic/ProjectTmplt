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

conan install .. -pr default --settings=build_type=${BUILD_TYPE} -s fmt:build_type=Release -s boost:build_type=Release
conan build -sf ../ ..
make install
conan export-pkg .. dev/stable -f -pf output -pr default --settings=build_type=${BUILD_TYPE}