module Lipgloss
  ( Color
  , color
  , adaptiveColor
  , completeColor
  , noColor
  , Hex(..)
  , Light(..)
  , Dark(..)
  , TrueColor(..)
  , Ansi256(..)
  , Ansi(..)

  , Style
  , newStyle
  , render
  , Text(..)
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
  , Bold(..)
  , Italic(..)
  , Underline(..)
  , Strikethrough(..)
  , Faint(..)
  , ReverseVideo(..)
  , Blink(..)
  , Inline(..)

  , padding
  , paddingTop
  , paddingRight
  , paddingBottom
  , paddingLeft
  , PadT(..)
  , PadR(..)
  , PadB(..)
  , PadL(..)

  , margin
  , marginTop
  , marginRight
  , marginBottom
  , marginLeft
  , MarT(..)
  , MarR(..)
  , MarB(..)
  , MarL(..)

  , width
  , height
  , maxWidth
  , maxHeight
  , Width(..)
  , Height(..)
  , MaxWidth(..)
  , MaxHeight(..)

  , Position
  , top, bottom, left, right, center
  , align
  , alignHorizontal
  , alignVertical
  , Horizontal(..)
  , Vertical(..)

  , BorderStyle
  , normalBorder
  , roundedBorder
  , thickBorder
  , doubleBorder
  , blockBorder
  , hiddenBorder
  , borderStyle
  , border
  , borderAll
  , borderSides
  , borderForeground
  , borderBackground
  , borderTop
  , borderRight
  , borderBottom
  , borderLeft
  , BorderTopOn(..)
  , BorderRightOn(..)
  , BorderBottomOn(..)
  , BorderLeftOn(..)

  , place
  , placeHorizontal
  , placeVertical
  , placeOverlay
  , X(..)
  , Y(..)
  , Over(..)
  , Under(..)
  , joinHorizontal
  , joinVertical
  , Columns(..)
  , Rows(..)

  -- legacy aliases for turbine2-era code
  , HorizontalPlacement
  , VerticalPlacement
  , centerH
  , centerV
  ) where

import Data.Function.Uncurried (Fn2, Fn3, Fn4, Fn5, Fn6, runFn2, runFn3, runFn4, runFn5, runFn6)
import Data.Newtype (class Newtype)

--------------------------------------------------------------------------------
-- Color
--------------------------------------------------------------------------------

foreign import data Color :: Type

newtype Hex = Hex String
newtype Light = Light String
newtype Dark = Dark String
newtype TrueColor = TrueColor String
newtype Ansi256 = Ansi256 String
newtype Ansi = Ansi String

derive instance Newtype Hex _
derive instance Newtype Light _
derive instance Newtype Dark _
derive instance Newtype TrueColor _
derive instance Newtype Ansi256 _
derive instance Newtype Ansi _

-- | A 24-bit hex color (`Hex "#ff8800"`), ANSI index as string (`Hex "196"`), or named color.
foreign import colorImpl :: Hex -> Color

color :: Hex -> Color
color = colorImpl

foreign import adaptiveColorImpl :: Fn2 Light Dark Color

-- | Picks `light` or `dark` based on the detected terminal background.
adaptiveColor :: Light -> Dark -> Color
adaptiveColor = runFn2 adaptiveColorImpl

foreign import completeColorImpl :: Fn3 TrueColor Ansi256 Ansi Color

-- | Full ANSI/256/TrueColor fallback specification.
completeColor :: TrueColor -> Ansi256 -> Ansi -> Color
completeColor = runFn3 completeColorImpl

foreign import noColor :: Color

--------------------------------------------------------------------------------
-- Style + render
--------------------------------------------------------------------------------

foreign import data Style :: Type

foreign import newStyle :: Style

newtype Text = Text String
derive instance Newtype Text _

foreign import renderImpl :: Fn2 Style Text String

render :: Style -> Text -> String
render = runFn2 renderImpl

foreign import stringWidth :: String -> Int
foreign import stringHeight :: String -> Int

--------------------------------------------------------------------------------
-- Color application
--------------------------------------------------------------------------------

foreign import foregroundImpl :: Fn2 Color Style Style
foreground :: Color -> Style -> Style
foreground = runFn2 foregroundImpl

foreign import backgroundImpl :: Fn2 Color Style Style
background :: Color -> Style -> Style
background = runFn2 backgroundImpl

--------------------------------------------------------------------------------
-- Text decoration toggles
--------------------------------------------------------------------------------

newtype Bold = Bold Boolean
newtype Italic = Italic Boolean
newtype Underline = Underline Boolean
newtype Strikethrough = Strikethrough Boolean
newtype Faint = Faint Boolean
newtype ReverseVideo = ReverseVideo Boolean
newtype Blink = Blink Boolean
newtype Inline = Inline Boolean

derive instance Newtype Bold _
derive instance Newtype Italic _
derive instance Newtype Underline _
derive instance Newtype Strikethrough _
derive instance Newtype Faint _
derive instance Newtype ReverseVideo _
derive instance Newtype Blink _
derive instance Newtype Inline _

foreign import boldImpl :: Fn2 Bold Style Style
bold :: Bold -> Style -> Style
bold = runFn2 boldImpl

foreign import italicImpl :: Fn2 Italic Style Style
italic :: Italic -> Style -> Style
italic = runFn2 italicImpl

foreign import underlineImpl :: Fn2 Underline Style Style
underline :: Underline -> Style -> Style
underline = runFn2 underlineImpl

foreign import strikethroughImpl :: Fn2 Strikethrough Style Style
strikethrough :: Strikethrough -> Style -> Style
strikethrough = runFn2 strikethroughImpl

foreign import faintImpl :: Fn2 Faint Style Style
faint :: Faint -> Style -> Style
faint = runFn2 faintImpl

foreign import reverseImpl :: Fn2 ReverseVideo Style Style

-- | Swap foreground and background (named `reverseVideo` to avoid the
-- | `Prelude.reverse` clash).
reverseVideo :: ReverseVideo -> Style -> Style
reverseVideo = runFn2 reverseImpl

foreign import blinkImpl :: Fn2 Blink Style Style
blink :: Blink -> Style -> Style
blink = runFn2 blinkImpl

foreign import inlineImpl :: Fn2 Inline Style Style
inline :: Inline -> Style -> Style
inline = runFn2 inlineImpl

--------------------------------------------------------------------------------
-- Padding & margin
--------------------------------------------------------------------------------

newtype PadT = PadT Int
newtype PadR = PadR Int
newtype PadB = PadB Int
newtype PadL = PadL Int

derive instance Newtype PadT _
derive instance Newtype PadR _
derive instance Newtype PadB _
derive instance Newtype PadL _

foreign import paddingImpl :: Fn5 PadT PadR PadB PadL Style Style

-- | Pad each side. TRBL order mirrors lipgloss's `Padding(t, r, b, l)`.
padding :: PadT -> PadR -> PadB -> PadL -> Style -> Style
padding = runFn5 paddingImpl

foreign import paddingTopImpl :: Fn2 PadT Style Style
paddingTop :: PadT -> Style -> Style
paddingTop = runFn2 paddingTopImpl

foreign import paddingRightImpl :: Fn2 PadR Style Style
paddingRight :: PadR -> Style -> Style
paddingRight = runFn2 paddingRightImpl

foreign import paddingBottomImpl :: Fn2 PadB Style Style
paddingBottom :: PadB -> Style -> Style
paddingBottom = runFn2 paddingBottomImpl

foreign import paddingLeftImpl :: Fn2 PadL Style Style
paddingLeft :: PadL -> Style -> Style
paddingLeft = runFn2 paddingLeftImpl

newtype MarT = MarT Int
newtype MarR = MarR Int
newtype MarB = MarB Int
newtype MarL = MarL Int

derive instance Newtype MarT _
derive instance Newtype MarR _
derive instance Newtype MarB _
derive instance Newtype MarL _

foreign import marginImpl :: Fn5 MarT MarR MarB MarL Style Style

-- | Margin each side. TRBL order mirrors lipgloss's `Margin(t, r, b, l)`.
margin :: MarT -> MarR -> MarB -> MarL -> Style -> Style
margin = runFn5 marginImpl

foreign import marginTopImpl :: Fn2 MarT Style Style
marginTop :: MarT -> Style -> Style
marginTop = runFn2 marginTopImpl

foreign import marginRightImpl :: Fn2 MarR Style Style
marginRight :: MarR -> Style -> Style
marginRight = runFn2 marginRightImpl

foreign import marginBottomImpl :: Fn2 MarB Style Style
marginBottom :: MarB -> Style -> Style
marginBottom = runFn2 marginBottomImpl

foreign import marginLeftImpl :: Fn2 MarL Style Style
marginLeft :: MarL -> Style -> Style
marginLeft = runFn2 marginLeftImpl

--------------------------------------------------------------------------------
-- Sizing
--------------------------------------------------------------------------------

newtype Width = Width Int
newtype Height = Height Int
newtype MaxWidth = MaxWidth Int
newtype MaxHeight = MaxHeight Int

derive instance Newtype Width _
derive instance Newtype Height _
derive instance Newtype MaxWidth _
derive instance Newtype MaxHeight _

foreign import widthImpl :: Fn2 Width Style Style
width :: Width -> Style -> Style
width = runFn2 widthImpl

foreign import heightImpl :: Fn2 Height Style Style
height :: Height -> Style -> Style
height = runFn2 heightImpl

foreign import maxWidthImpl :: Fn2 MaxWidth Style Style
maxWidth :: MaxWidth -> Style -> Style
maxWidth = runFn2 maxWidthImpl

foreign import maxHeightImpl :: Fn2 MaxHeight Style Style
maxHeight :: MaxHeight -> Style -> Style
maxHeight = runFn2 maxHeightImpl

--------------------------------------------------------------------------------
-- Position + alignment
--------------------------------------------------------------------------------

foreign import data Position :: Type

foreign import top :: Position
foreign import bottom :: Position
foreign import left :: Position
foreign import right :: Position
foreign import center :: Position

newtype Horizontal = Horizontal Position
newtype Vertical = Vertical Position

derive instance Newtype Horizontal _
derive instance Newtype Vertical _

foreign import alignImpl :: Fn3 Horizontal Vertical Style Style

align :: Horizontal -> Vertical -> Style -> Style
align = runFn3 alignImpl

foreign import alignHorizontalImpl :: Fn2 Horizontal Style Style
alignHorizontal :: Horizontal -> Style -> Style
alignHorizontal = runFn2 alignHorizontalImpl

foreign import alignVerticalImpl :: Fn2 Vertical Style Style
alignVertical :: Vertical -> Style -> Style
alignVertical = runFn2 alignVerticalImpl

--------------------------------------------------------------------------------
-- Borders
--------------------------------------------------------------------------------

foreign import data BorderStyle :: Type

foreign import normalBorder :: BorderStyle
foreign import roundedBorder :: BorderStyle
foreign import thickBorder :: BorderStyle
foreign import doubleBorder :: BorderStyle
foreign import blockBorder :: BorderStyle
foreign import hiddenBorder :: BorderStyle

foreign import borderStyleImpl :: Fn2 BorderStyle Style Style

borderStyle :: BorderStyle -> Style -> Style
borderStyle = runFn2 borderStyleImpl

newtype BorderTopOn = BorderTopOn Boolean
newtype BorderRightOn = BorderRightOn Boolean
newtype BorderBottomOn = BorderBottomOn Boolean
newtype BorderLeftOn = BorderLeftOn Boolean

derive instance Newtype BorderTopOn _
derive instance Newtype BorderRightOn _
derive instance Newtype BorderBottomOn _
derive instance Newtype BorderLeftOn _

foreign import borderImpl :: Fn6 BorderStyle BorderTopOn BorderRightOn BorderBottomOn BorderLeftOn Style Style

-- | Apply a border with explicit per-side toggles, matching
-- | `lipgloss.Style.Border(b, top, right, bottom, left)`.
border :: BorderStyle -> BorderTopOn -> BorderRightOn -> BorderBottomOn -> BorderLeftOn -> Style -> Style
border = runFn6 borderImpl

-- | Apply a border to all four sides.
borderAll :: BorderStyle -> Style -> Style
borderAll b = border b (BorderTopOn true) (BorderRightOn true) (BorderBottomOn true) (BorderLeftOn true)

-- | Alias for `border` that signals intent: explicit per-side toggles.
borderSides :: BorderStyle -> BorderTopOn -> BorderRightOn -> BorderBottomOn -> BorderLeftOn -> Style -> Style
borderSides = border

foreign import borderForegroundImpl :: Fn2 Color Style Style
borderForeground :: Color -> Style -> Style
borderForeground = runFn2 borderForegroundImpl

foreign import borderBackgroundImpl :: Fn2 Color Style Style
borderBackground :: Color -> Style -> Style
borderBackground = runFn2 borderBackgroundImpl

foreign import borderTopImpl :: Fn2 BorderTopOn Style Style
borderTop :: BorderTopOn -> Style -> Style
borderTop = runFn2 borderTopImpl

foreign import borderRightImpl :: Fn2 BorderRightOn Style Style
borderRight :: BorderRightOn -> Style -> Style
borderRight = runFn2 borderRightImpl

foreign import borderBottomImpl :: Fn2 BorderBottomOn Style Style
borderBottom :: BorderBottomOn -> Style -> Style
borderBottom = runFn2 borderBottomImpl

foreign import borderLeftImpl :: Fn2 BorderLeftOn Style Style
borderLeft :: BorderLeftOn -> Style -> Style
borderLeft = runFn2 borderLeftImpl

--------------------------------------------------------------------------------
-- Placement
--------------------------------------------------------------------------------

foreign import placeImpl :: Fn5 Width Height Horizontal Vertical Text String

-- | Pad the string to the given box using the supplied alignment.
place :: Width -> Height -> Horizontal -> Vertical -> Text -> String
place = runFn5 placeImpl

foreign import placeHorizontalImpl :: Fn3 Width Horizontal Text String

placeHorizontal :: Width -> Horizontal -> Text -> String
placeHorizontal = runFn3 placeHorizontalImpl

foreign import placeVerticalImpl :: Fn3 Height Vertical Text String

placeVertical :: Height -> Vertical -> Text -> String
placeVertical = runFn3 placeVerticalImpl

newtype X = X Int
newtype Y = Y Int
newtype Over = Over String
newtype Under = Under String

derive instance Newtype X _
derive instance Newtype Y _
derive instance Newtype Over _
derive instance Newtype Under _

foreign import placeOverlayImpl :: Fn4 X Y Over Under String

-- | Composite `over` on top of `under` with its top-left at column `x`,
-- | row `y`. ANSI-aware: styles in both layers are preserved; cells the
-- | overlay covers replace the base.
placeOverlay :: X -> Y -> Over -> Under -> String
placeOverlay = runFn4 placeOverlayImpl

--------------------------------------------------------------------------------
-- Join
--------------------------------------------------------------------------------

newtype Columns = Columns (Array String)
newtype Rows = Rows (Array String)

derive instance Newtype Columns _
derive instance Newtype Rows _

foreign import joinHorizontalImpl :: Fn2 Vertical Columns String

-- | Stitch columns side by side, aligned vertically.
joinHorizontal :: Vertical -> Columns -> String
joinHorizontal = runFn2 joinHorizontalImpl

foreign import joinVerticalImpl :: Fn2 Horizontal Rows String

-- | Stack rows top-to-bottom, aligned horizontally.
joinVertical :: Horizontal -> Rows -> String
joinVertical = runFn2 joinVerticalImpl

--------------------------------------------------------------------------------
-- Legacy aliases preserved so turbine2-era code still compiles.
--------------------------------------------------------------------------------

type HorizontalPlacement = Position
type VerticalPlacement = Position

centerH :: Position
centerH = center

centerV :: Position
centerV = center
