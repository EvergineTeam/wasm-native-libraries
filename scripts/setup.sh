#!/bin/bash
set -e

# To know the version used by the sdk, look at the manifest of the workload nuget
# For example, for net8: https://nuget.info/packages/Microsoft.NET.Workload.Emscripten.Current.Manifest-8.0.100/8.0.8
#   Then go to data/WorkloadManifest.json and looks the packs, like the 'Microsoft.NET.Runtime.Emscripten.Python.net8'
EMSDK_VERSION=3.1.34

# EMSDK
mkdir -p ./thirdparty
pushd ./thirdparty
git clone https://github.com/emscripten-core/emsdk.git
cd emsdk
./emsdk install $EMSDK_VERSION
./emsdk activate $EMSDK_VERSION
popd