#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

EMSDK_PATH="$SCRIPT_DIR/../../thirdparty/emsdk/emsdk_env.sh"
VCGLIB_WASM_PINVOKE_DIR=$SCRIPT_DIR/vcglib-sharp-wasm
VCGLIB_NATIVE_FACADE_DIR=$VCGLIB_WASM_PINVOKE_DIR/vcglib_wasm
VCGLIB_NATIVE_DIR=$VCGLIB_NATIVE_FACADE_DIR/vcglib
BLAZOR_DEMO_DIR=$SCRIPT_DIR/BlazorDemo

echo "VCGLIB_WASM_PINVOKE_DIR: $VCGLIB_WASM_PINVOKE_DIR"
echo "VCGLIB_NATIVE_FACADE_DIR: $VCGLIB_NATIVE_FACADE_DIR"
echo "VCGLIB_NATIVE_DIR: $VCGLIB_NATIVE_DIR"

cd $SCRIPT_DIR
echo "updating repos"
git submodule init
git submodule update

echo "Cleaning Blazor directories"
rm -R BlazorDemo/bin BlazorDemo/obj BlazorDemo/*.a > /dev/null

pushd `pwd`
echo "---------------------------------------------------"
cd $SCRIPT_DIR

echo "activating emsdk environment"
source $EMSDK_PATH > /dev/null

echo "moving to vcglib native facade directory"
cd $VCGLIB_NATIVE_FACADE_DIR
echo "building vcglib c++"
mkdir -p build
cd build/
emcmake cmake ..
make

echo "----------------------------------------------------"

echo "copying vcglib c++ static library to 'BlazorDemo' project and 'vcglib-sharp-wasm pinvoke project'"
echo " - copying static library"

echo  `pwd`
cp libvcglib_facade.a $VCGLIB_NATIVE_FACADE_DIR && cp libvcglib_facade.a $BLAZOR_DEMO_DIR

echo "Building blazor demo and pinvoke library"
cd $BLAZOR_DEMO_DIR
dotnet build

popd

