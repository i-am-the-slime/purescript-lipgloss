module Lipgloss.Table
  ( Table
  , Data
  , StyleFunc
  , new
  , render
  , rows
  , row
  , headers
  , data_
  , border
  , borderStyle
  , borderTop
  , borderBottom
  , borderLeft
  , borderRight
  , borderHeader
  , borderColumn
  , borderRow
  , borderForeground
  , width
  , height
  , offset
  , wrap
  , styleFunc
  ) where

import Data.Function.Uncurried (Fn2, runFn2)
import Effect (Effect)
import Lipgloss (BorderStyle, Color, Style)

foreign import data Table :: Type

foreign import data Data :: Type

type StyleFunc = { row :: Int, col :: Int } -> Style

foreign import new :: Effect Table

foreign import render :: Table -> String

foreign import rowsImpl :: Fn2 (Array (Array String)) Table Table
rows :: Array (Array String) -> Table -> Table
rows = runFn2 rowsImpl

foreign import rowImpl :: Fn2 (Array String) Table Table
row :: Array String -> Table -> Table
row = runFn2 rowImpl

foreign import headersImpl :: Fn2 (Array String) Table Table
headers :: Array String -> Table -> Table
headers = runFn2 headersImpl

foreign import dataImpl :: Fn2 Data Table Table
data_ :: Data -> Table -> Table
data_ = runFn2 dataImpl

foreign import borderImpl :: Fn2 BorderStyle Table Table
border :: BorderStyle -> Table -> Table
border = runFn2 borderImpl

foreign import borderStyleImpl :: Fn2 Style Table Table
borderStyle :: Style -> Table -> Table
borderStyle = runFn2 borderStyleImpl

foreign import borderTopImpl :: Fn2 Boolean Table Table
borderTop :: Boolean -> Table -> Table
borderTop = runFn2 borderTopImpl

foreign import borderBottomImpl :: Fn2 Boolean Table Table
borderBottom :: Boolean -> Table -> Table
borderBottom = runFn2 borderBottomImpl

foreign import borderLeftImpl :: Fn2 Boolean Table Table
borderLeft :: Boolean -> Table -> Table
borderLeft = runFn2 borderLeftImpl

foreign import borderRightImpl :: Fn2 Boolean Table Table
borderRight :: Boolean -> Table -> Table
borderRight = runFn2 borderRightImpl

foreign import borderHeaderImpl :: Fn2 Boolean Table Table
borderHeader :: Boolean -> Table -> Table
borderHeader = runFn2 borderHeaderImpl

foreign import borderColumnImpl :: Fn2 Boolean Table Table
borderColumn :: Boolean -> Table -> Table
borderColumn = runFn2 borderColumnImpl

foreign import borderRowImpl :: Fn2 Boolean Table Table
borderRow :: Boolean -> Table -> Table
borderRow = runFn2 borderRowImpl

foreign import borderForegroundImpl :: Fn2 Color Table Table
borderForeground :: Color -> Table -> Table
borderForeground = runFn2 borderForegroundImpl

foreign import widthImpl :: Fn2 Int Table Table
width :: Int -> Table -> Table
width = runFn2 widthImpl

foreign import heightImpl :: Fn2 Int Table Table
height :: Int -> Table -> Table
height = runFn2 heightImpl

foreign import offsetImpl :: Fn2 Int Table Table
offset :: Int -> Table -> Table
offset = runFn2 offsetImpl

foreign import wrapImpl :: Fn2 Boolean Table Table
wrap :: Boolean -> Table -> Table
wrap = runFn2 wrapImpl

foreign import styleFuncImpl :: Fn2 StyleFunc Table Table

-- | Per-cell styling. `{ row: -1, col: c }` targets header cells.
styleFunc :: StyleFunc -> Table -> Table
styleFunc = runFn2 styleFuncImpl
