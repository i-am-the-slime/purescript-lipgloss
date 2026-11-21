-- | Trees, like a file browser shows them.
-- |
-- |     Tree.render (Node "src" [ Leaf "Main.purs", Node "Data" [ Leaf "List.purs" ] ])
module Lipgloss.Tree
  ( Tree(..)
  , render
  , renderWith
  , Looks
  , defaultLooks
  , Enumerator
  , defaultEnumerator
  , roundedEnumerator
  ) where

import Prelude

import Lipgloss (Style, newStyle, paddingRight)

data Tree = Leaf String | Node String (Array Tree)

-- | How a tree is drawn.
type Looks =
  { enumerator :: Enumerator
  , enumeratorStyle :: Style
  , rootStyle :: Style
  , itemStyle :: Style
  }

defaultLooks :: Looks
defaultLooks = { enumerator: defaultEnumerator, enumeratorStyle: paddingRight 1 newStyle, rootStyle: newStyle, itemStyle: newStyle }

render :: Tree -> String
render = renderWith defaultLooks

renderWith :: Looks -> Tree -> String
renderWith looks tree = renderImpl (native tree)
  where
  native = case _ of
    Leaf text -> treeImpl looks.enumerator looks.enumeratorStyle looks.rootStyle looks.itemStyle text []
    Node text children -> treeImpl looks.enumerator looks.enumeratorStyle looks.rootStyle looks.itemStyle text (map child children)
  child = case _ of
    Leaf text -> leafNode text
    node -> subtreeNode (native node)

foreign import treeImpl :: Enumerator -> Style -> Style -> Style -> String -> Array Child -> NativeTree
foreign import leafNode :: String -> Child
foreign import subtreeNode :: NativeTree -> Child
foreign import renderImpl :: NativeTree -> String

-- | The lines that lead to an item: `├──` or `╰──`.
foreign import data Enumerator :: Type

foreign import defaultEnumerator :: Enumerator
foreign import roundedEnumerator :: Enumerator

foreign import data NativeTree :: Type
foreign import data Child :: Type
