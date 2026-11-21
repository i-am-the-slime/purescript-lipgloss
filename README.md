# purescript-lipgloss

Style text for the terminal in PureScript, with [Lip Gloss](https://github.com/charmbracelet/lipgloss):
colors, padding, borders, alignment, and blocks you can put side by side. For PureScript compiled
to Go with [Iris](https://github.com/i-am-the-slime/purescript-analyzer/tree/iris-go).

```purescript
import Lipgloss as L
import Lipgloss.Charmtone as C
import Lipgloss.Sx (Sx(..))
import Lipgloss.Sx as Style

card :: String -> String -> String
card title body = Style.render frame (L.joinVertical L.left [ Style.render heading title, body ])
  where
  frame = Style.do
    Border L.roundedBorder Style.all
    BorderFg C.charple
    PadX 1
    MarR 1
  heading = Style.do
    Fg C.dolly
    Bold true
    MarB 1
```

A style written with `Style.do` is plain data: one line per property, and `Style.guard` to add one
only sometimes:

```purescript
Bg theme.primary # Style.guard (i == selected)
```

If you'd rather chain, every property is also a function on `Style`:

```purescript
L.render (L.newStyle # L.border L.roundedBorder # L.padding 0 1 0 1) "hi"
```

```
╭────╮
│ hi │
╰────╯
```

## Colors

`L.color "#FF60FF"` or an ANSI number like `L.color "205"`. `Lipgloss.Charmtone` has the whole
Charm palette (`C.charple`, `C.dolly`, `C.pepper`, …), and `L.lightDark isDark light dark` picks one
for the terminal's background.

## Layout

| | |
| --- | --- |
| `joinHorizontal L.top [ a, b ]` | side by side, lined up at the top (or `center`, `bottom`) |
| `joinVertical L.left [ a, b ]` | one above the other |
| `place { width: 80, height: 24 } L.center L.center text` | in the middle of a box |
| `placeOverlay { x: 10, y: 3 } dialog screen` | a dialog over the screen, colors and all |
| `stringWidth`, `stringHeight` | the size, ignoring colors |

`Lipgloss.Painted` keeps a background color going across spans, so light terminals don't show
through:

```purescript
chrome = paint C.bbq
header = chrome.bold C.charple " CRUSH " <> chrome.plain C.smoke "  ~/code" <> blankRow C.bbq 20
```

`Lipgloss.Layout` builds rows and columns that share out the space: `row [ fixed 30 sidebar, flex 1 chat ]`.

## Tables, lists and trees

They're records with defaults, so you change what you need:

```purescript
Table.render Table.defaults
  { headers = [ "Language", "Formal", "Informal" ]
  , rows = [ [ "German", "Guten Tag", "Moin" ], [ "Japanese", "こんにちは", "やあ" ] ]
  , border = L.roundedBorder
  , style = \row _ -> if row == Table.header then L.newStyle # L.bold true else L.newStyle
  }

List.render (List.list [])
  { items = [ Item "Fruit", Nested (List.list [ "Apple", "Pear" ]) { enumerator = List.roman } ] }

Tree.render (Node "src" [ Leaf "Main.purs", Node "Data" [ Leaf "List.purs" ] ])
```

```
src
├── Main.purs
└── Data
    └── List.purs
```

## Showcase

```bash
cd examples && ./run.sh Showcase
```

## Changes from the old bindings

- Setters take plain values: `L.width 20`, `L.bold true`, `L.padding 0 1 0 1`. `render` takes a
  `String`, not a `Text`.
- `border kind` draws all four sides; `borderSides kind { top, right, bottom, left }` some of them.
  `borderStyle`, `borderAll` and the per-side `borderTop` … are gone.
- `place` takes `{ width, height }`, `placeOverlay` takes `{ x, y }`, `joinHorizontal` and
  `joinVertical` take a plain `Array String`.
- `adaptiveColor` and `completeColor` are gone; use `lightDark`.
- `Table`, `List` and `Tree` are pure records instead of builders on a mutable value.
- Lip Gloss v2.1 from `charm.land`.

## Go only

There are no `.js` files: this package only works with Iris's Go backend. Run `./test.sh` for the
specs.
