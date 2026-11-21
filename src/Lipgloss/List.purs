-- | Lists, nested as deep as you like.
-- |
-- |     List.render (List.list [ "Bread", "Butter" ])
-- |
-- |     List.render (List.list [])
-- |       { items = [ Item "Fruit", Nested (List.list [ "Apple", "Pear" ]) { enumerator = List.roman } ] }
module Lipgloss.List
  ( List
  , Item(..)
  , list
  , render
  , Enumerator
  , bullet
  , asterisk
  , dash
  , arabic
  , alphabet
  , roman
  ) where

import Prelude

import Lipgloss (Style, newStyle, paddingRight)

type List =
  { items :: Array Item
  , enumerator :: Enumerator
  , enumeratorStyle :: Style
  , itemStyle :: Style
  }

data Item = Item String | Nested List

-- | A bulleted list of plain items.
list :: Array String -> List
list texts = { items: map Item texts, enumerator: bullet, enumeratorStyle: paddingRight 1 newStyle, itemStyle: newStyle }

render :: List -> String
render = renderImpl <<< native

native :: List -> NativeList
native { items, enumerator, enumeratorStyle, itemStyle } = listImpl enumerator enumeratorStyle itemStyle (map node items)
  where
  node = case _ of
    Item text -> itemNode text
    Nested inner -> nestedNode (native inner)

-- | What goes in front of an item: `•`, `1.`, `a.`, `I.` and so on.
foreign import data Enumerator :: Type

foreign import bullet :: Enumerator
foreign import asterisk :: Enumerator
foreign import dash :: Enumerator
foreign import arabic :: Enumerator
foreign import alphabet :: Enumerator
foreign import roman :: Enumerator

foreign import data NativeList :: Type
foreign import data Node :: Type

foreign import listImpl :: Enumerator -> Style -> Style -> Array Node -> NativeList
foreign import itemNode :: String -> Node
foreign import nestedNode :: NativeList -> Node
foreign import renderImpl :: NativeList -> String
