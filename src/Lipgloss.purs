module Lipgloss where

import Data.Function.Uncurried (Fn2, Fn3, Fn5, runFn2, runFn3, runFn5)
import Effect (Effect)

foreign import data Color :: Type

foreign import color :: String -> Color

foreign import data Style :: Type

foreign import newStyle :: Effect Style

foreign import renderImpl :: Fn2 Style String String

render ∷ Style → String -> String
render = runFn2 renderImpl

foreign import foregroundImpl :: Fn2 Color Style Style

foreground ∷ Color → Style → Style
foreground = runFn2 foregroundImpl

foreign import backgroundImpl :: Fn2 Color Style Style

background ∷ Color → Style → Style
background = runFn2 backgroundImpl

foreign import boldImpl :: Fn2 Boolean Style Style

bold ∷ Boolean -> Style -> Style
bold = runFn2 boldImpl

foreign import italicImpl :: Fn2 Boolean Style Style

italic ∷ Boolean -> Style -> Style
italic = runFn2 italicImpl

foreign import underlineImpl :: Fn2 Boolean Style Style

underline ∷ Boolean -> Style -> Style
underline = runFn2 underlineImpl

newtype PaddingRight = PaddingRight Int
newtype PaddingLeft = PaddingLeft Int
newtype PaddingTop = PaddingTop Int
newtype PaddingBottom = PaddingBottom Int

foreign import paddingImpl :: Fn5 PaddingTop PaddingRight PaddingBottom PaddingLeft Style Style

padding ∷ PaddingTop → PaddingRight → PaddingBottom → PaddingLeft → Style → Style
padding = runFn5 paddingImpl

foreign import paddingTopImpl :: Fn2 Int Style Style

paddingTop ∷ Int → Style → Style
paddingTop = runFn2 paddingTopImpl

foreign import paddingRightImpl :: Fn2 Int Style Style

paddingRight ∷ Int → Style → Style
paddingRight = runFn2 paddingRightImpl

foreign import paddingBottomImpl :: Fn2 Int Style Style

paddingBottom ∷ Int → Style → Style
paddingBottom = runFn2 paddingBottomImpl

foreign import paddingLeftImpl :: Fn2 Int Style Style

paddingLeft ∷ Int → Style → Style
paddingLeft = runFn2 paddingLeftImpl

foreign import widthImpl :: Fn2 Int Style Style

width ∷ Int → Style → Style
width = runFn2 widthImpl

foreign import data BorderStyle :: Type

foreign import roundedBorder :: BorderStyle

foreign import borderStyleImpl :: Fn2 BorderStyle Style Style

borderStyle ∷ BorderStyle → Style → Style
borderStyle = runFn2 borderStyleImpl

foreign import borderForegroundImpl :: Fn2 Color Style Style

borderForeground ∷ Color → Style → Style
borderForeground = runFn2 borderForegroundImpl

foreign import data HorizontalPlacement :: Type
foreign import left :: HorizontalPlacement
foreign import right :: HorizontalPlacement
foreign import centerH :: HorizontalPlacement

foreign import placeHorizontalImpl :: Fn3 Int HorizontalPlacement String String

placeHorizontal :: Int -> HorizontalPlacement -> String -> String
placeHorizontal = runFn3 placeHorizontalImpl

foreign import data VerticalPlacement :: Type
foreign import top :: VerticalPlacement
foreign import bottom :: VerticalPlacement
foreign import centerV :: VerticalPlacement

foreign import placeVerticalImpl :: Fn3 Int VerticalPlacement String String

placeVertical :: Int -> VerticalPlacement -> String -> String
placeVertical = runFn3 placeVerticalImpl

