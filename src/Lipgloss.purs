module Lipgloss
  ( Color
  , color
  , adaptiveColor
  , completeColor
  , noColor

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

  , width
  , height
  , maxWidth
  , maxHeight

  , Position
  , top, bottom, left, right, center
  , align
  , alignHorizontal
  , alignVertical

  , BorderStyle
  , normalBorder
  , roundedBorder
  , thickBorder
  , doubleBorder
  , blockBorder
  , hiddenBorder
  , borderStyle
  , border
  , borderForeground
  , borderBackground
  , borderTop
  , borderRight
  , borderBottom
  , borderLeft

  , place
  , placeHorizontal
  , placeVertical
  , joinHorizontal
  , joinVertical

  -- legacy aliases for turbine2-era code
  , HorizontalPlacement
  , VerticalPlacement
  , centerH
  , centerV
  ) where

import Data.Function.Uncurried (Fn2, Fn3, Fn5, Fn6, runFn2, runFn3, runFn5, runFn6)

foreign import data Color :: Type

-- | A 24-bit hex color (`"#ff8800"`), ANSI index as string (`"196"`), or named color.
foreign import color :: String -> Color

foreign import adaptiveColorImpl :: Fn2 String String Color

-- | Picks `light` or `dark` based on the detected terminal background.
adaptiveColor :: { light :: String, dark :: String } -> Color
adaptiveColor { light, dark } = runFn2 adaptiveColorImpl light dark

foreign import completeColorImpl :: Fn3 String String String Color

-- | Full ANSI/256/TrueColor fallback specification.
completeColor :: { trueColor :: String, ansi256 :: String, ansi :: String } -> Color
completeColor { trueColor, ansi256, ansi } = runFn3 completeColorImpl trueColor ansi256 ansi

foreign import noColor :: Color

foreign import data Style :: Type

foreign import newStyle :: Style

foreign import renderImpl :: Fn2 Style String String

render :: Style -> String -> String
render = runFn2 renderImpl

foreign import stringWidth :: String -> Int
foreign import stringHeight :: String -> Int

foreign import foregroundImpl :: Fn2 Color Style Style
foreground :: Color -> Style -> Style
foreground = runFn2 foregroundImpl

foreign import backgroundImpl :: Fn2 Color Style Style
background :: Color -> Style -> Style
background = runFn2 backgroundImpl

foreign import boldImpl :: Fn2 Boolean Style Style
bold :: Boolean -> Style -> Style
bold = runFn2 boldImpl

foreign import italicImpl :: Fn2 Boolean Style Style
italic :: Boolean -> Style -> Style
italic = runFn2 italicImpl

foreign import underlineImpl :: Fn2 Boolean Style Style
underline :: Boolean -> Style -> Style
underline = runFn2 underlineImpl

foreign import strikethroughImpl :: Fn2 Boolean Style Style
strikethrough :: Boolean -> Style -> Style
strikethrough = runFn2 strikethroughImpl

foreign import faintImpl :: Fn2 Boolean Style Style
faint :: Boolean -> Style -> Style
faint = runFn2 faintImpl

foreign import reverseImpl :: Fn2 Boolean Style Style

-- | Swap foreground and background (named `reverseVideo` to avoid the
-- | `Prelude.reverse` clash).
reverseVideo :: Boolean -> Style -> Style
reverseVideo = runFn2 reverseImpl

foreign import blinkImpl :: Fn2 Boolean Style Style
blink :: Boolean -> Style -> Style
blink = runFn2 blinkImpl

foreign import inlineImpl :: Fn2 Boolean Style Style
inline :: Boolean -> Style -> Style
inline = runFn2 inlineImpl

foreign import paddingImpl :: Fn5 Int Int Int Int Style Style

-- | `padding top right bottom left`. Mirrors lipgloss's TRBL order.
padding :: Int -> Int -> Int -> Int -> Style -> Style
padding = runFn5 paddingImpl

foreign import paddingTopImpl :: Fn2 Int Style Style
paddingTop :: Int -> Style -> Style
paddingTop = runFn2 paddingTopImpl

foreign import paddingRightImpl :: Fn2 Int Style Style
paddingRight :: Int -> Style -> Style
paddingRight = runFn2 paddingRightImpl

foreign import paddingBottomImpl :: Fn2 Int Style Style
paddingBottom :: Int -> Style -> Style
paddingBottom = runFn2 paddingBottomImpl

foreign import paddingLeftImpl :: Fn2 Int Style Style
paddingLeft :: Int -> Style -> Style
paddingLeft = runFn2 paddingLeftImpl

foreign import marginImpl :: Fn5 Int Int Int Int Style Style
margin :: Int -> Int -> Int -> Int -> Style -> Style
margin = runFn5 marginImpl

foreign import marginTopImpl :: Fn2 Int Style Style
marginTop :: Int -> Style -> Style
marginTop = runFn2 marginTopImpl

foreign import marginRightImpl :: Fn2 Int Style Style
marginRight :: Int -> Style -> Style
marginRight = runFn2 marginRightImpl

foreign import marginBottomImpl :: Fn2 Int Style Style
marginBottom :: Int -> Style -> Style
marginBottom = runFn2 marginBottomImpl

foreign import marginLeftImpl :: Fn2 Int Style Style
marginLeft :: Int -> Style -> Style
marginLeft = runFn2 marginLeftImpl

foreign import widthImpl :: Fn2 Int Style Style
width :: Int -> Style -> Style
width = runFn2 widthImpl

foreign import heightImpl :: Fn2 Int Style Style
height :: Int -> Style -> Style
height = runFn2 heightImpl

foreign import maxWidthImpl :: Fn2 Int Style Style
maxWidth :: Int -> Style -> Style
maxWidth = runFn2 maxWidthImpl

foreign import maxHeightImpl :: Fn2 Int Style Style
maxHeight :: Int -> Style -> Style
maxHeight = runFn2 maxHeightImpl

foreign import data Position :: Type

foreign import top :: Position
foreign import bottom :: Position
foreign import left :: Position
foreign import right :: Position
foreign import center :: Position

foreign import alignImpl :: Fn3 Position Position Style Style

-- | `align horizontal vertical`.
align :: Position -> Position -> Style -> Style
align = runFn3 alignImpl

foreign import alignHorizontalImpl :: Fn2 Position Style Style
alignHorizontal :: Position -> Style -> Style
alignHorizontal = runFn2 alignHorizontalImpl

foreign import alignVerticalImpl :: Fn2 Position Style Style
alignVertical :: Position -> Style -> Style
alignVertical = runFn2 alignVerticalImpl

foreign import data BorderStyle :: Type

foreign import normalBorder :: BorderStyle
foreign import roundedBorder :: BorderStyle
foreign import thickBorder :: BorderStyle
foreign import doubleBorder :: BorderStyle
foreign import blockBorder :: BorderStyle
foreign import hiddenBorder :: BorderStyle

foreign import borderStyleImpl :: Fn2 BorderStyle Style Style

-- | Apply a border to all four sides.
borderStyle :: BorderStyle -> Style -> Style
borderStyle = runFn2 borderStyleImpl

foreign import borderImpl :: Fn6 BorderStyle Boolean Boolean Boolean Boolean Style Style

-- | Apply a border with explicit per-side toggles, matching
-- | `lipgloss.Style.Border(b, top, right, bottom, left)`.
border :: BorderStyle -> { top :: Boolean, right :: Boolean, bottom :: Boolean, left :: Boolean } -> Style -> Style
border b sides = runFn6 borderImpl b sides.top sides.right sides.bottom sides.left

foreign import borderForegroundImpl :: Fn2 Color Style Style
borderForeground :: Color -> Style -> Style
borderForeground = runFn2 borderForegroundImpl

foreign import borderBackgroundImpl :: Fn2 Color Style Style
borderBackground :: Color -> Style -> Style
borderBackground = runFn2 borderBackgroundImpl

foreign import borderTopImpl :: Fn2 Boolean Style Style
borderTop :: Boolean -> Style -> Style
borderTop = runFn2 borderTopImpl

foreign import borderRightImpl :: Fn2 Boolean Style Style
borderRight :: Boolean -> Style -> Style
borderRight = runFn2 borderRightImpl

foreign import borderBottomImpl :: Fn2 Boolean Style Style
borderBottom :: Boolean -> Style -> Style
borderBottom = runFn2 borderBottomImpl

foreign import borderLeftImpl :: Fn2 Boolean Style Style
borderLeft :: Boolean -> Style -> Style
borderLeft = runFn2 borderLeftImpl

foreign import placeImpl :: Fn5 Int Int Position Position String String

-- | `place width height horizontalPosition verticalPosition content` — pad
-- | the string to the given box using the supplied alignment.
place :: Int -> Int -> Position -> Position -> String -> String
place = runFn5 placeImpl

foreign import placeHorizontalImpl :: Fn3 Int Position String String

placeHorizontal :: Int -> Position -> String -> String
placeHorizontal = runFn3 placeHorizontalImpl

foreign import placeVerticalImpl :: Fn3 Int Position String String

placeVertical :: Int -> Position -> String -> String
placeVertical = runFn3 placeVerticalImpl

foreign import joinHorizontalImpl :: Fn2 Position (Array String) String

-- | `joinHorizontal verticalAlign columns` — stitch columns side by side.
joinHorizontal :: Position -> Array String -> String
joinHorizontal = runFn2 joinHorizontalImpl

foreign import joinVerticalImpl :: Fn2 Position (Array String) String

-- | `joinVertical horizontalAlign rows` — stack rows top-to-bottom.
joinVertical :: Position -> Array String -> String
joinVertical = runFn2 joinVerticalImpl

-- Legacy aliases preserved so turbine2-era code still compiles.
type HorizontalPlacement = Position
type VerticalPlacement = Position

centerH :: Position
centerH = center

centerV :: Position
centerV = center
