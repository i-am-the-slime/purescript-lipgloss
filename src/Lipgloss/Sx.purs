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
-- |     Style.render style "hi"
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
import Lipgloss (Border, Color, Position, Style, newStyle)
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
  | Border Border Sides
  | BorderFg Color
  | BorderBg Color

  -- Alignment
  | Align Position Position
  | AlignH Position
  | AlignV Position

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

    Width n -> L.width n s
    Height n -> L.height n s
    MaxWidth n -> L.maxWidth n s
    MaxHeight n -> L.maxHeight n s

    PadT n -> L.paddingTop n s
    PadR n -> L.paddingRight n s
    PadB n -> L.paddingBottom n s
    PadL n -> L.paddingLeft n s
    PadX n -> L.paddingLeft n (L.paddingRight n s)
    PadY n -> L.paddingTop n (L.paddingBottom n s)

    MarT n -> L.marginTop n s
    MarR n -> L.marginRight n s
    MarB n -> L.marginBottom n s
    MarL n -> L.marginLeft n s
    MarX n -> L.marginLeft n (L.marginRight n s)
    MarY n -> L.marginTop n (L.marginBottom n s)

    Bold b -> L.bold b s
    Italic b -> L.italic b s
    Underline b -> L.underline b s
    Strikethrough b -> L.strikethrough b s
    Faint b -> L.faint b s
    ReverseVideo b -> L.reverseVideo b s
    Blink b -> L.blink b s
    Inline b -> L.inline b s

    Border kind sides -> L.borderSides kind (un Sides sides) s
    BorderFg c -> L.borderForeground c s
    BorderBg c -> L.borderBackground c s

    Align horizontal vertical -> L.align horizontal vertical s
    AlignH horizontal -> L.alignHorizontal horizontal s
    AlignV vertical -> L.alignVertical vertical s

-- | Render text through an Sx — the common case.
render :: Sx -> String -> String
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

