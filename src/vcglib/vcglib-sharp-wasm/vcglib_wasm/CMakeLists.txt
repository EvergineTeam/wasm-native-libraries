cmake_minimum_required(VERSION 3.12)
project(vcglib_wasm_facade)

set(CMAKE_CXX_STANDARD 11)

if (EMSCRIPTEN)
    set(CMAKE_EXECUTABLE_SUFFIX ".html") 
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -s WASM=1") 
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -s USE_WEBGL2=1 ") 
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -s SIDE_MODULE=1")
endif()

include_directories(vcglib vcglib/eigenlib)

message(STATUS "VCGlib include dir: ${VCG_INCLUDE_DIR}")
add_library(vcglib_facade vcglib_facade.cpp)
