#ifndef WASM_NATIVE_H_
#define WASM_NATIVE_H_

typedef struct struct_example
{
    int number;
    double decimal;
} struct_example;

typedef void (*callback)(void);

#ifdef __cplusplus
extern "C"
{
#endif

    int hello();
    void callCbk(callback cbk);

#ifdef __cplusplus
} // extern "C"
#endif

#endif // WASM_NATIVE_H_