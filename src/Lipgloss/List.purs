module Lipgloss.List
  ( List
  , Enumerator
  , new
  , render
  , item
  , items
  , itemList
  , enumerator
  , enumeratorStyle
  , itemStyle
  , offset
  , hide
  , bullet
  , asterisk
  , dash
  , arabic
  , alphabet
  , roman
  ) where

import Data.Function.Uncurried (Fn2, runFn2)
import Effect (Effect)
import Lipgloss (Style)

foreign import data List :: Type
foreign import data Enumerator :: Type

foreign import new :: Effect List

foreign import render :: List -> String

foreign import itemImpl :: Fn2 String List List
item :: String -> List -> List
item = runFn2 itemImpl

foreign import itemsImpl :: Fn2 (Array String) List List
items :: Array String -> List -> List
items = runFn2 itemsImpl

foreign import itemListImpl :: Fn2 List List List

-- | Nest a sublist beneath the previous item.
itemList :: List -> List -> List
itemList = runFn2 itemListImpl

foreign import enumeratorImpl :: Fn2 Enumerator List List
enumerator :: Enumerator -> List -> List
enumerator = runFn2 enumeratorImpl

foreign import enumeratorStyleImpl :: Fn2 Style List List
enumeratorStyle :: Style -> List -> List
enumeratorStyle = runFn2 enumeratorStyleImpl

foreign import itemStyleImpl :: Fn2 Style List List
itemStyle :: Style -> List -> List
itemStyle = runFn2 itemStyleImpl

foreign import offsetImpl :: Fn2 { start :: Int, end :: Int } List List
offset :: { start :: Int, end :: Int } -> List -> List
offset = runFn2 offsetImpl

foreign import hideImpl :: Fn2 Boolean List List
hide :: Boolean -> List -> List
hide = runFn2 hideImpl

foreign import bullet :: Enumerator
foreign import asterisk :: Enumerator
foreign import dash :: Enumerator
foreign import arabic :: Enumerator
foreign import alphabet :: Enumerator
foreign import roman :: Enumerator
