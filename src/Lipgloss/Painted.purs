-- | Painted text spans that carry an ambient background, so concatenated
-- | fragments share a bg without each call site having to pass it.
-- |
-- | Pattern:
-- |
-- |     chrome = paint C.bbq
-- |     header = chrome.bold C.charple " CRUSH "
-- |           <> chrome.plain C.smoke "  ~/Developer/markgraf"
-- |           <> chrome.dim   C.oyster " m modals · q quit "
module Lipgloss.Painted
  ( Painted(..)
  , Painter
  , paint
  , unpaint
  , text
  , blankRow
  , padToWidth
  ) where

import Prelude

import Data.Newtype (class Newtype, un)
import Lipgloss (Bold(..), Color, Faint(..), Text(..), background, bold, faint, foreground, newStyle, render, stringWidth)

newtype Painted = Painted { bg :: Color, text :: String }

derive instance Newtype Painted _

-- | Two painted spans concatenate by joining their rendered text. The left
-- | span's `bg` wins so the resulting Painted reports a consistent ambient
-- | background.
instance Semigroup Painted where
  append (Painted a) (Painted b) = Painted { bg: a.bg, text: a.text <> b.text }

-- | The set of constructors `paint` returns, bound to a single bg.
type Painter =
  { plain :: Color -> String -> Painted
  , bold :: Color -> String -> Painted
  , dim :: Color -> String -> Painted
  , raw :: String -> Painted
  }

paint :: Color -> Painter
paint bg =
  { plain: \fg s -> Painted { bg, text: render (base fg) (Text s) }
  , bold: \fg s -> Painted { bg, text: render (bold (Bold true) (base fg)) (Text s) }
  , dim: \fg s -> Painted { bg, text: render (faint (Faint true) (base fg)) (Text s) }
  , raw: \s -> Painted { bg, text: s }
  }
  where
  base fg = foreground fg (background bg newStyle)

-- | Render a Painted back to a raw escape-coded string for placement into a
-- | Style/render pipeline.
unpaint :: Painted -> String
unpaint = _.text <<< un Painted

-- | The rendered string component, alias for `unpaint`.
text :: Painted -> String
text = unpaint

-- | A horizontal run of `n` bg-painted spaces — useful for filling rows so
-- | the chrome color reaches all the way across a panel.
blankRow :: Color -> Int -> Painted
blankRow bg n = Painted { bg, text: render (background bg newStyle) (Text (spaces n)) }
  where
  spaces k
    | k <= 0 = ""
    | otherwise = " " <> spaces (k - 1)

-- | Pad a painted span to the given visual width by appending bg-painted
-- | spaces on the right. The bg of the existing Painted is used.
padToWidth :: Int -> Painted -> Painted
padToWidth target p@(Painted { bg, text: t }) =
  let current = stringWidth t
      fillCount = max 0 (target - current)
  in p <> blankRow bg fillCount
