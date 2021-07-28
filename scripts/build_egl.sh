#!/bin/bash
set -e

PROJECT_PATH=$(pwd)

BIN_PATH="$(pwd)/bin"
EMSDK_PATH="$(pwd)/thirdparty/emsdk/emsdk_env.sh"

source $EMSDK_PATH > /dev/null

# pushd $EMSDK/upstream/emscripten/system/include
# rm -rf $BIN_PATH
# mkdir -p $BIN_PATH
# emcc EGL/egl.h -c -o $BIN_PATH/libEGL.o
# popd

rm -rf $BIN_PATH
mkdir -p $BIN_PATH
pushd ./src
emcc egl.c -I system/include -c -o $BIN_PATH/libEGL.o
popd
