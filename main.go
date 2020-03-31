package  main 

import "fmt"
import "runtime"

func main(){
	fmt.Println("Go Version:", runtime.Version())
		fmt.Println("Compiler:", runtime.Compiler)
		fmt.Printf("Platform: %s/%s\n", runtime.GOOS, runtime.GOARCH)
	}
