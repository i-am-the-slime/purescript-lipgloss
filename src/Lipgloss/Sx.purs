-- | A declarative style expression. Build it up with constructors (or a
-- | qualified-do block), translate to a real `Lipgloss.Style` via
-- | `toStyle`. Pure data — inspectable, composable, swappable.
-- |
-- |     style = Style.do
-- |       Width 32
-- |       Bg theme.bgChrome
-- |       Fg theme.fgSubtle
-- |       PadT 1
-- |       Border L.normalBorder Style.right
-- |       BorderFg C.charcoal
-- |
-- |     L.render (toStyle style) (Text "hi")
module Lipgloss.Sx
  ( Sx(..)
  , toStyle
  , render
  , discard
  , guard

  , Sides(..)
  , top, right, bottom, left, all
  ) where

import Prelude hiding (top, bottom)

import Data.Newtype (class Newtype, un)
import Lipgloss (BorderBottomOn(..), BorderLeftOn(..), BorderRightOn(..), BorderStyle, BorderTopOn(..), Color, Horizontal, Style, Text, Vertical, newStyle)
import Lipgloss as L

-- | Every visual property the user can declare. `Compose` and `None`
-- | give us a `Semigroup`/`Monoid`, which is also what powers `Style.do`.
data Sx
  = None
  | Compose Sx Sx

  -- Color
  | Fg Color
  | Bg Color

  -- Sizing
  | Width Int
  | Height Int
  | MaxWidth Int
  | MaxHeight Int

  -- Padding (sides + axis shortcuts)
  | PadT Int
  | PadR Int
  | PadB Int
  | PadL Int
  | PadX Int
  | PadY Int

  -- Margin
  | MarT Int
  | MarR Int
  | MarB Int
  | MarL Int
  | MarX Int
  | MarY Int

  -- Decoration toggles
  | Bold Boolean
  | Italic Boolean
  | Underline Boolean
  | Strikethrough Boolean
  | Faint Boolean
  | ReverseVideo Boolean
  | Blink Boolean
  | Inline Boolean

  -- Borders
  | Border BorderStyle Sides
  | BorderFg Color
  | BorderBg Color

  -- Alignment
  | Align Horizontal Vertical
  | AlignH Horizontal
  | AlignV Vertical

instance Semigroup Sx where
  append = Compose

instance Monoid Sx where
  mempty = None

-- | Translate the declarative spec into a `Lipgloss.Style` by folding
-- | each constructor into the equivalent lipgloss setter.
toStyle :: Sx -> Style
toStyle = go newStyle
  where
  go s = case _ of
    None -> s
    Compose a b -> go (go s a) b

    Fg c -> L.foreground c s
    Bg c -> L.background c s

    Width n -> L.width (L.Width n) s
    Height n -> L.height (L.Height n) s
    MaxWidth n -> L.maxWidth (L.MaxWidth n) s
    MaxHeight n -> L.maxHeight (L.MaxHeight n) s

    PadT n -> L.paddingTop (L.PadT n) s
    PadR n -> L.paddingRight (L.PadR n) s
    PadB n -> L.paddingBottom (L.PadB n) s
    PadL n -> L.paddingLeft (L.PadL n) s
    PadX n -> L.paddingLeft (L.PadL n) (L.paddingRight (L.PadR n) s)
    PadY n -> L.paddingTop (L.PadT n) (L.paddingBottom (L.PadB n) s)

    MarT n -> L.marginTop (L.MarT n) s
    MarR n -> L.marginRight (L.MarR n) s
    MarB n -> L.marginBottom (L.MarB n) s
    MarL n -> L.marginLeft (L.MarL n) s
    MarX n -> L.marginLeft (L.MarL n) (L.marginRight (L.MarR n) s)
    MarY n -> L.marginTop (L.MarT n) (L.marginBottom (L.MarB n) s)

    Bold b -> L.bold (L.Bold b) s
    Italic b -> L.italic (L.Italic b) s
    Underline b -> L.underline (L.Underline b) s
    Strikethrough b -> L.strikethrough (L.Strikethrough b) s
    Faint b -> L.faint (L.Faint b) s
    ReverseVideo b -> L.reverseVideo (L.ReverseVideo b) s
    Blink b -> L.blink (L.Blink b) s
    Inline b -> L.inline (L.Inline b) s

    Border bs sides ->
      let sd = un Sides sides
      in L.border bs (BorderTopOn sd.top) (BorderRightOn sd.right) (BorderBottomOn sd.bottom) (BorderLeftOn sd.left)
           (L.borderStyle bs s)
    BorderFg c -> L.borderForeground c s
    BorderBg c -> L.borderBackground c s

    Align hp vp -> L.align hp vp s
    AlignH hp -> L.alignHorizontal hp s
    AlignV vp -> L.alignVertical vp s

-- | Render text through an Sx — the common case.
render :: Sx -> Text -> String
render sx = L.render (toStyle sx)

-- | Powers `Style.do` — concatenate adjacent statements.
discard :: Sx -> (Unit -> Sx) -> Sx
discard a f = a <> f unit

-- | Contribute the fragment only when the predicate holds.
-- |
-- |     Bg theme.primary # Style.guard (i == selected)
guard :: Boolean -> Sx -> Sx
guard cond a = if cond then a else None

--------------------------------------------------------------------------------
-- Border sides — compose with <>, then attach a BorderStyle.
--
--     Border L.roundedBorder all
--     Border L.normalBorder (top <> right)
--------------------------------------------------------------------------------

newtype Sides = Sides { top :: Boolean, right :: Boolean, bottom :: Boolean, left :: Boolean }

derive instance Newtype Sides _

instance Semigroup Sides where
  append (Sides a) (Sides b) = Sides
    { top: a.top || b.top
    , right: a.right || b.right
    , bottom: a.bottom || b.bottom
    , left: a.left || b.left
    }

instance Monoid Sides where
  mempty = Sides { top: false, right: false, bottom: false, left: false }

top :: Sides
top = Sides { top: true, right: false, bottom: false, left: false }

right :: Sides
right = Sides { top: false, right: true, bottom: false, left: false }

bottom :: Sides
bottom = Sides { top: false, right: false, bottom: true, left: false }

left :: Sides
left = Sides { top: false, right: false, bottom: false, left: true }

all :: Sides
all = top <> right <> bottom <> left

