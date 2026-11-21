-- | A small declarative layout DSL on top of `joinHorizontal` / `joinVertical`
-- | / `place`. Trees of `Layout` resolve to a width × height box; the
-- | renderer distributes `Flex` space and inserts `Painted` blanks so a
-- | chrome color reaches all the way across.
module Lipgloss.Layout
  ( Layout(..)
  , text
  , row
  , col
  , fixed
  , flex
  , pad
  , bordered
  , renderLayout
  ) where

import Prelude

import Data.Array (filter, replicate, zipWith)
import Data.Foldable (sum)
import Data.String (Pattern(..), split) as String
import Data.String.Common (joinWith) as String
import Lipgloss (Border, Color, Position, border, borderForeground, joinHorizontal, joinVertical, left, newStyle, render)
import Lipgloss as L
import Lipgloss.Painted (Painted, blankRow, unpaint)

-- | A box. `Row` / `Col` lay out children; `Fixed` and `Flex` mark sizing
-- | along the parent axis; `Pad` adds inner spacing; `Border` wraps a box.
data Layout
  = Text Painted
  | Row Position (Array Layout)
  | Col Position (Array Layout)
  | Fixed Int Layout
  | Flex Int Layout
  | Pad { top :: Int, right :: Int, bottom :: Int, left :: Int } Layout
  | Border Border Color Layout

-- Friendly constructors so call sites read top-down.

text :: Painted -> Layout
text = Text

row :: Array Layout -> Layout
row = Row L.top

col :: Array Layout -> Layout
col = Col left

fixed :: Int -> Layout -> Layout
fixed = Fixed

flex :: Int -> Layout -> Layout
flex = Flex

pad :: { top :: Int, right :: Int, bottom :: Int, left :: Int } -> Layout -> Layout
pad = Pad

bordered :: Border -> Color -> Layout -> Layout
bordered = Border

-- | Render a Layout tree into a multi-line string sized to fit the given
-- | box. Background-painted spacers fill leftover space in Flex children
-- | and along the cross-axis when contents are shorter than the box.
renderLayout :: { width :: Int, height :: Int } -> Color -> Layout -> String
renderLayout box bg = case _ of
  Text painted -> unpaint painted

  Row align children ->
    joinHorizontal align
      $ zipWith
          (\size child -> renderLayout { width: size, height: box.height } bg child)
          (distribute box.width children)
          children

  Col align children ->
    joinVertical align
      $ zipWith
          (\size child -> renderLayout { width: box.width, height: size } bg child)
          (distribute box.height children)
          children

  Fixed _ child -> renderLayout box bg child

  Flex _ child -> renderLayout box bg child

  Pad sides child -> renderPadded box bg sides child

  Border kind color child -> renderBordered box bg kind color child

renderPadded :: { width :: Int, height :: Int } -> Color -> { top :: Int, right :: Int, bottom :: Int, left :: Int } -> Layout -> String
renderPadded box bg sides child = String.joinWith "\n" (filter (_ /= "") [ blanks sides.top, padded, blanks sides.bottom ])
  where
  inner = renderLayout { width: max 0 (box.width - sides.left - sides.right), height: max 0 (box.height - sides.top - sides.bottom) } bg child
  padded = String.joinWith "\n" ((\line -> gap sides.left <> line <> gap sides.right) <$> splitLines inner)
  gap n = unpaint (blankRow bg n)
  blanks n = String.joinWith "\n" (replicate n (gap box.width))

renderBordered :: { width :: Int, height :: Int } -> Color -> Border -> Color -> Layout -> String
renderBordered box bg kind color child = render (borderForeground color (border kind newStyle)) inner
  where
  inner = renderLayout { width: max 0 (box.width - 2), height: max 0 (box.height - 2) } bg child

splitLines :: String -> Array String
splitLines = String.split (String.Pattern "\n")

-- Allocate parent-axis space across children. Fixed children take their
-- declared size; Flex children split the remainder by weight; plain
-- children share whatever's left equally.
distribute :: Int -> Array Layout -> Array Int
distribute total children = assign <$> children
  where
  fixedTotal = sum (fixedSize <$> children)
  flexTotal = sum (flexWeight <$> children)
  leftover = max 0 (total - fixedTotal)

  fixedSize :: Layout -> Int
  fixedSize = case _ of
    Fixed n _ -> n
    _ -> 0

  flexWeight :: Layout -> Int
  flexWeight = case _ of
    Flex w _ -> w
    Fixed _ _ -> 0
    _ -> 1

  assign :: Layout -> Int
  assign = case _ of
    Fixed n _ -> n
    Flex w _
      | flexTotal <= 0 -> 0
      | otherwise -> (leftover * w) / flexTotal
    _
      | flexTotal <= 0 -> 0
      | otherwise -> leftover / flexTotal
