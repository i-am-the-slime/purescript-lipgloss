package ffi

import "os"

func Exit(code int32) { os.Exit(int(code)) }
