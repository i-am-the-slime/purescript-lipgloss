module Showcase where

import Prelude

import Effect (Effect)
import Effect.Console (log)
import Lipgloss as L
import Lipgloss.Charmtone as C
import Lipgloss.List (Item(..))
import Lipgloss.List as List
import Lipgloss.Sx (Sx(..))
import Lipgloss.Sx as Style
import Lipgloss.Table as Table
import Lipgloss.Tree (Tree(..))
import Lipgloss.Tree as Tree

main :: Effect Unit
main = do
  log (L.joinHorizontal L.top [ card "Sx" (Style.render decorated "bold, italic, underlined"), card "Borders" borders ])
  log (L.joinHorizontal L.top [ card "Table" table, card "List" list, card "Tree" tree ])
  log (card "Placement" placement)

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

decorated :: Sx
decorated = Style.do
  Fg C.butter
  Bg C.charple
  Bold true
  Italic true
  Underline true
  PadX 2

borders :: String
borders = L.joinHorizontal L.center
  [ box L.normalBorder "normal"
  , box L.roundedBorder "rounded"
  , box L.thickBorder "thick"
  , box L.doubleBorder "double"
  ]
  where
  box kind label = L.render (L.newStyle # L.border kind # L.borderForeground C.guac # L.padding 0 1 0 1) label

table :: String
table = Table.render Table.defaults
  { headers = [ "Language", "Formal", "Informal" ]
  , rows =
      [ [ "German", "Guten Tag", "Moin" ]
      , [ "Japanese", "こんにちは", "やあ" ]
      , [ "Spanish", "Buenos días", "Hola" ]
      ]
  , border = L.roundedBorder
  , borderStyle = L.newStyle # L.foreground C.squid
  , style = \row _ -> if row == Table.header then L.newStyle # L.bold true # L.foreground C.malibu # L.padding 0 1 0 1 else L.newStyle # L.padding 0 1 0 1
  }

list :: String
list = List.render (List.list [])
  { items =
      [ Item "Fruit"
      , Nested (List.list [ "Apple", "Pear" ]) { enumerator = List.roman }
      , Item "Vegetables"
      , Nested (List.list [ "Leek", "Kale" ]) { enumerator = List.dash }
      ]
  , enumeratorStyle = L.newStyle # L.foreground C.dolly # L.paddingRight 1
  }

tree :: String
tree = Tree.renderWith Tree.defaultLooks { enumerator = Tree.roundedEnumerator, rootStyle = L.newStyle # L.bold true }
  (Node "src" [ Leaf "Main.purs", Node "Data" [ Leaf "List.purs", Leaf "Map.purs" ], Leaf "Effect.purs" ])

placement :: String
placement = L.place { width: 40, height: 3 } L.center L.center (Style.render decorated "centered in 40×3")
