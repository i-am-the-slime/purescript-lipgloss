module Lipgloss.Tree
  ( Tree
  , Enumerator
  , new
  , render
  , root
  , child
  , childTree
  , enumerator
  , enumeratorStyle
  , rootStyle
  , itemStyle
  , offset
  , hide
  , defaultEnumerator
  , roundedEnumerator
  ) where

import Data.Function.Uncurried (Fn2, runFn2)
import Effect (Effect)
import Lipgloss (Style)

foreign import data Tree :: Type
foreign import data Enumerator :: Type

foreign import new :: Effect Tree

foreign import render :: Tree -> String

foreign import rootImpl :: Fn2 String Tree Tree
root :: String -> Tree -> Tree
root = runFn2 rootImpl

foreign import childImpl :: Fn2 (Array String) Tree Tree

-- | Add leaf children (strings).
child :: Array String -> Tree -> Tree
child = runFn2 childImpl

foreign import childTreeImpl :: Fn2 Tree Tree Tree

-- | Nest a subtree as a child.
childTree :: Tree -> Tree -> Tree
childTree = runFn2 childTreeImpl

foreign import enumeratorImpl :: Fn2 Enumerator Tree Tree
enumerator :: Enumerator -> Tree -> Tree
enumerator = runFn2 enumeratorImpl

foreign import enumeratorStyleImpl :: Fn2 Style Tree Tree
enumeratorStyle :: Style -> Tree -> Tree
enumeratorStyle = runFn2 enumeratorStyleImpl

foreign import rootStyleImpl :: Fn2 Style Tree Tree
rootStyle :: Style -> Tree -> Tree
rootStyle = runFn2 rootStyleImpl

foreign import itemStyleImpl :: Fn2 Style Tree Tree
itemStyle :: Style -> Tree -> Tree
itemStyle = runFn2 itemStyleImpl

foreign import offsetImpl :: Fn2 { start :: Int, end :: Int } Tree Tree
offset :: { start :: Int, end :: Int } -> Tree -> Tree
offset = runFn2 offsetImpl

foreign import hideImpl :: Fn2 Boolean Tree Tree
hide :: Boolean -> Tree -> Tree
hide = runFn2 hideImpl

foreign import defaultEnumerator :: Enumerator
foreign import roundedEnumerator :: Enumerator
