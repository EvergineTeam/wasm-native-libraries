#include "wasm_native.h"

#include <stdio.h>
#include <string.h>

#include "emscripten.h"

int hello()
{
    EM_ASM({ console.log("Hello from Wasm Native Library!"); });
    return 42;
}

void callCbk(callback cbk)
{
    EM_ASM({ console.log("Calling .Net callback..."); });
    cbk();
    EM_ASM({ console.log("Callback all right!"); });
}