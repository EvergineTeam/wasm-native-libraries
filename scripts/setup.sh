#!/bin/bash
set -e

EMSDK_VERSION=2.0.23

# EMSDK
mkdir -p ./thirdparty
pushd ./thirdparty
git clone git@github.com:emscripten-core/emsdk.git
cd emsdk
./emsdk install $EMSDK_VERSION
./emsdk activate $EMSDK_VERSION
popd