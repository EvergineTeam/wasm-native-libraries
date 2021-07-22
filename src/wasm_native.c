#include "wasm_native.h"

#include <stdio.h>
#include <string.h>

#include "emscripten.h"

int hello()
{
    printf("Hello from Wasm Native Library!");
    return 42;
}