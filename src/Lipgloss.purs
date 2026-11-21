-- | Styles, borders and layout for the terminal, on Lip Gloss.
-- |
-- |     title = L.newStyle # L.bold true # L.foreground (L.color "#FF60FF") # L.padding 0 1 0 1
-- |     L.render title "Hello"
-- |
-- | For whole styles at once, `Lipgloss.Sx` reads nicer.
module Lipgloss
  ( Color
  , color
  , noColor
  , lightDark

  , Style
  , newStyle
  , render
  , stringWidth
  , stringHeight

  , foreground
  , background
  , bold
  , italic
  , underline
  , strikethrough
  , faint
  , reverseVideo
  , blink
  , inline

  , padding
  , paddingTop
  , paddingRight
  , paddingBottom
  , paddingLeft
  , margin
  , marginTop
  , marginRight
  , marginBottom
  , marginLeft
  , marginBackground

  , width
  , height
  , maxWidth
  , maxHeight

  , Position
  , top
  , bottom
  , left
  , right
  , center
  , align
  , alignHorizontal
  , alignVertical

  , Border
  , normalBorder
  , roundedBorder
  , thickBorder
  , doubleBorder
  , blockBorder
  , hiddenBorder
  , asciiBorder
  , markdownBorder
  , border
  , borderSides
  , borderForeground
  , borderBackground

  , place
  , placeHorizontal
  , placeVertical
  , placeOverlay
  , joinHorizontal
  , joinVertical
  ) where

import Prelude hiding (top, bottom)

--------------------------------------------------------------------------------
-- Colors
--------------------------------------------------------------------------------

foreign import data Color :: Type

-- | A hex color (`"#FF60FF"`) or an ANSI color number (`"205"`).
color :: String -> Color
color = colorImpl

foreign import colorImpl :: String -> Color

-- | No color: the terminal's default.
foreign import noColor :: Color

-- | `lightDark isDark light dark` picks the color for the terminal's background.
lightDark :: Boolean -> Color -> Color -> Color
lightDark = lightDarkImpl

foreign import lightDarkImpl :: Boolean -> Color -> Color -> Color

--------------------------------------------------------------------------------
-- Styles
--------------------------------------------------------------------------------

-- | How text looks. Styles are values: every setter makes a new one.
foreign import data Style :: Type

foreign import newStyle :: Style

render :: Style -> String -> String
render = renderImpl

foreign import renderImpl :: Style -> String -> String

-- | The width of the widest line, in cells, ignoring colors and styles.
stringWidth :: String -> Int
stringWidth = stringWidthImpl

-- | The number of lines.
stringHeight :: String -> Int
stringHeight = stringHeightImpl

foreign import stringWidthImpl :: String -> Int
foreign import stringHeightImpl :: String -> Int

foreground :: Color -> Style -> Style
foreground = foregroundImpl

background :: Color -> Style -> Style
background = backgroundImpl

foreign import foregroundImpl :: Color -> Style -> Style
foreign import backgroundImpl :: Color -> Style -> Style

bold :: Boolean -> Style -> Style
bold = boldImpl

italic :: Boolean -> Style -> Style
italic = italicImpl

underline :: Boolean -> Style -> Style
underline = underlineImpl

strikethrough :: Boolean -> Style -> Style
strikethrough = strikethroughImpl

faint :: Boolean -> Style -> Style
faint = faintImpl

-- | Swap the text and background colors.
reverseVideo :: Boolean -> Style -> Style
reverseVideo = reverseImpl

blink :: Boolean -> Style -> Style
blink = blinkImpl

-- | Render on one line: no padding, margins or borders, newlines dropped.
inline :: Boolean -> Style -> Style
inline = inlineImpl

foreign import boldImpl :: Boolean -> Style -> Style
foreign import italicImpl :: Boolean -> Style -> Style
foreign import underlineImpl :: Boolean -> Style -> Style
foreign import strikethroughImpl :: Boolean -> Style -> Style
foreign import faintImpl :: Boolean -> Style -> Style
foreign import reverseImpl :: Boolean -> Style -> Style
foreign import blinkImpl :: Boolean -> Style -> Style
foreign import inlineImpl :: Boolean -> Style -> Style

-- | Top, right, bottom, left, in cells.
padding :: Int -> Int -> Int -> Int -> Style -> Style
padding = paddingImpl

paddingTop :: Int -> Style -> Style
paddingTop = paddingTopImpl

paddingRight :: Int -> Style -> Style
paddingRight = paddingRightImpl

paddingBottom :: Int -> Style -> Style
paddingBottom = paddingBottomImpl

paddingLeft :: Int -> Style -> Style
paddingLeft = paddingLeftImpl

foreign import paddingImpl :: Int -> Int -> Int -> Int -> Style -> Style
foreign import paddingTopImpl :: Int -> Style -> Style
foreign import paddingRightImpl :: Int -> Style -> Style
foreign import paddingBottomImpl :: Int -> Style -> Style
foreign import paddingLeftImpl :: Int -> Style -> Style

-- | Top, right, bottom, left, in cells.
margin :: Int -> Int -> Int -> Int -> Style -> Style
margin = marginImpl

marginTop :: Int -> Style -> Style
marginTop = marginTopImpl

marginRight :: Int -> Style -> Style
marginRight = marginRightImpl

marginBottom :: Int -> Style -> Style
marginBottom = marginBottomImpl

marginLeft :: Int -> Style -> Style
marginLeft = marginLeftImpl

-- | The color of the margins.
marginBackground :: Color -> Style -> Style
marginBackground = marginBackgroundImpl

foreign import marginImpl :: Int -> Int -> Int -> Int -> Style -> Style
foreign import marginTopImpl :: Int -> Style -> Style
foreign import marginRightImpl :: Int -> Style -> Style
foreign import marginBottomImpl :: Int -> Style -> Style
foreign import marginLeftImpl :: Int -> Style -> Style
foreign import marginBackgroundImpl :: Color -> Style -> Style

-- | Wrap the text to this many cells, padding included.
width :: Int -> Style -> Style
width = widthImpl

height :: Int -> Style -> Style
height = heightImpl

-- | Cut lines longer than this.
maxWidth :: Int -> Style -> Style
maxWidth = maxWidthImpl

-- | Cut text taller than this.
maxHeight :: Int -> Style -> Style
maxHeight = maxHeightImpl

foreign import widthImpl :: Int -> Style -> Style
foreign import heightImpl :: Int -> Style -> Style
foreign import maxWidthImpl :: Int -> Style -> Style
foreign import maxHeightImpl :: Int -> Style -> Style

--------------------------------------------------------------------------------
-- Positions
--------------------------------------------------------------------------------

-- | Where between two edges: `left` and `top` are the start, `center` the
-- | middle, `right` and `bottom` the end.
foreign import data Position :: Type

foreign import top :: Position
foreign import bottom :: Position
foreign import left :: Position
foreign import right :: Position
foreign import center :: Position

-- | Horizontal, then vertical.
align :: Position -> Position -> Style -> Style
align = alignImpl

alignHorizontal :: Position -> Style -> Style
alignHorizontal = alignHorizontalImpl

alignVertical :: Position -> Style -> Style
alignVertical = alignVerticalImpl

foreign import alignImpl :: Position -> Position -> Style -> Style
foreign import alignHorizontalImpl :: Position -> Style -> Style
foreign import alignVerticalImpl :: Position -> Style -> Style

--------------------------------------------------------------------------------
-- Borders
--------------------------------------------------------------------------------

foreign import data Border :: Type

foreign import normalBorder :: Border
foreign import roundedBorder :: Border
foreign import thickBorder :: Border
foreign import doubleBorder :: Border
foreign import blockBorder :: Border
foreign import hiddenBorder :: Border
foreign import asciiBorder :: Border
foreign import markdownBorder :: Border

-- | A border all around.
border :: Border -> Style -> Style
border kind = borderSides kind { top: true, right: true, bottom: true, left: true }

-- | A border on some sides.
-- |
-- |     L.borderSides L.normalBorder { top: false, right: true, bottom: false, left: false }
borderSides :: Border -> { top :: Boolean, right :: Boolean, bottom :: Boolean, left :: Boolean } -> Style -> Style
borderSides kind sides = borderImpl kind sides.top sides.right sides.bottom sides.left

foreign import borderImpl :: Border -> Boolean -> Boolean -> Boolean -> Boolean -> Style -> Style

borderForeground :: Color -> Style -> Style
borderForeground = borderForegroundImpl

borderBackground :: Color -> Style -> Style
borderBackground = borderBackgroundImpl

foreign import borderForegroundImpl :: Color -> Style -> Style
foreign import borderBackgroundImpl :: Color -> Style -> Style

--------------------------------------------------------------------------------
-- Layout
--------------------------------------------------------------------------------

-- | Put text in a box of the given size.
-- |
-- |     L.place { width: 80, height: 24 } L.center L.center "hi"
place :: { width :: Int, height :: Int } -> Position -> Position -> String -> String
place box = placeImpl box.width box.height

placeHorizontal :: Int -> Position -> String -> String
placeHorizontal = placeHorizontalImpl

placeVertical :: Int -> Position -> String -> String
placeVertical = placeVerticalImpl

foreign import placeImpl :: Int -> Int -> Position -> Position -> String -> String
foreign import placeHorizontalImpl :: Int -> Position -> String -> String
foreign import placeVerticalImpl :: Int -> Position -> String -> String

-- | Draw text over other text, its top left corner at a column and row.
-- |
-- |     L.placeOverlay { x: 10, y: 3 } dialog screen
placeOverlay :: { x :: Int, y :: Int } -> String -> String -> String
placeOverlay at = placeOverlayImpl at.x at.y

foreign import placeOverlayImpl :: Int -> Int -> String -> String -> String

-- | Side by side, lined up at the position (`top`, `center`, `bottom`).
joinHorizontal :: Position -> Array String -> String
joinHorizontal = joinHorizontalImpl

-- | One above the other, lined up at the position (`left`, `center`, `right`).
joinVertical :: Position -> Array String -> String
joinVertical = joinVerticalImpl

foreign import joinHorizontalImpl :: Position -> Array String -> String
foreign import joinVerticalImpl :: Position -> Array String -> String
