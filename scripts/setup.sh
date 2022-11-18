#!/bin/bash
set -e

EMSDK_VERSION=2.0.23

# build dependencies
sudo apt update && sudo apt install build-essential cmake ninja-build -y

# EMSDK
mkdir -p ./thirdparty
pushd ./thirdparty
git clone git@github.com:emscripten-core/emsdk.git
cd emsdk
./emsdk install $EMSDK_VERSION
./emsdk activate $EMSDK_VERSION
popd