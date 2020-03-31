package main

// #include <stdio.h>
// #include <stdlib.h>
import "C"
import (
	"fmt"
	"runtime"
	"unsafe"
)

func printtext(s string) {
	cs := C.CString(s)
	C.fputs(cs, (*C.FILE)(C.stdout))
	C.free(unsafe.Pointer(cs))
}

func main() {
	printtext("hello world\n")
	printtext("hello world hello world\n")
	fmt.Println("Go Version:", runtime.Version())
	fmt.Println("Compiler:", runtime.Compiler)
	fmt.Printf("Platform: %s/%s\n", runtime.GOOS, runtime.GOARCH)
}
