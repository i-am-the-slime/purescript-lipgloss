module project.localhost/example

go 1.24.3

replace project.localhost/purescript-native/ffi-loader => ./purescript-native

replace project.localhost/purescript-native/output => ./output

replace github.com/i-am-the-slime/purescript-lipgloss/ffi => ../../ffi

replace github.com/i-am-the-slime/go-ffi => /Users/mark/Developer/go-ffi

replace github.com/purescript-native/go-ffi => github.com/joprice/purescript-native-go-ffi v0.0.0-20230319170919-df001aa880fd

require (
	github.com/aymanbagabas/go-osc52/v2 v2.0.1 // indirect
	github.com/charmbracelet/colorprofile v0.2.3-0.20250311203215-f60798e515dc // indirect
	github.com/charmbracelet/lipgloss v1.1.0 // indirect
	github.com/charmbracelet/x/ansi v0.8.0 // indirect
	github.com/charmbracelet/x/cellbuf v0.0.13-0.20250311204145-2c3ea96c31dd // indirect
	github.com/charmbracelet/x/term v0.2.1 // indirect
	github.com/i-am-the-slime/go-ffi v0.0.0-00010101000000-000000000000 // indirect
	github.com/i-am-the-slime/purescript-lipgloss/ffi v0.0.0-00010101000000-000000000000 // indirect
	github.com/lucasb-eyer/go-colorful v1.2.0 // indirect
	github.com/mattn/go-isatty v0.0.20 // indirect
	github.com/mattn/go-runewidth v0.0.16 // indirect
	github.com/muesli/termenv v0.16.0 // indirect
	github.com/purescript-native/go-runtime v0.1.2 // indirect
	github.com/rivo/uniseg v0.4.7 // indirect
	github.com/xo/terminfo v0.0.0-20220910002029-abceb7e1c41e // indirect
	golang.org/x/sys v0.30.0 // indirect
	project.localhost/purescript-native/ffi-loader v0.0.0-00010101000000-000000000000 // indirect
	project.localhost/purescript-native/output v0.0.0-00010101000000-000000000000 // indirect
)
