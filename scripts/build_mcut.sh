#!/bin/bash
set -e

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

PROJECT_PATH=$(realpath "$SCRIPT_DIR/..")

MCUT_PATH="$PROJECT_PATH/thirdparty/mcut"
BIN_PATH="$MCUT_PATH/build/wasm"
EMSDK_PATH="$PROJECT_PATH/thirdparty/emsdk/emsdk_env.sh"

source $EMSDK_PATH > /dev/null

rm -rf $BIN_PATH
mkdir -p $BIN_PATH

emcmake cmake $MCUT_PATH -B $BIN_PATH \
    --log-level=VERBOSE \
    -DMCUT_BUILD_AS_SHARED_LIB=OFF \
    -DMCUT_BUILD_WITH_MULTITHREADING=OFF

pushd $BIN_PATH
emmake make -j4
popd

echo "Library succesfully created at $BIN_PATH/lib"
