#!/bin/bash
set -e

PROJECT_PATH=$(pwd)

BIN_PATH="$(pwd)/bin"
EMSDK_PATH="$(pwd)/thirdparty/emsdk/emsdk_env.sh"

source $EMSDK_PATH > /dev/null

rm -rf $BIN_PATH
mkdir -p $BIN_PATH
pushd ./src
emcc wasm_native.c -I system/include -c -o $BIN_PATH/libWasmNative.o
popd