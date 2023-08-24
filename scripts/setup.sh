#!/bin/bash
set -e

# To know the version used by the sdk, look at the manifest of the workload nuget
# For example, for net7: https://nuget.info/packages/Microsoft.NET.Workload.Emscripten.net7.Manifest-7.0.100/7.0.10
#   Then go to data/WorkloadManifest.json and looks the packs, like the 'Microsoft.NET.Runtime.Emscripten.Python.net7'
EMSDK_VERSION=3.1.12

# EMSDK
mkdir -p ./thirdparty
pushd ./thirdparty
git clone git@github.com:emscripten-core/emsdk.git
cd emsdk
./emsdk install $EMSDK_VERSION
./emsdk activate $EMSDK_VERSION
popd