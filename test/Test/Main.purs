module Test.Main where

import Prelude

import Data.Identity (Identity(..))
import Data.Newtype (un)
import Effect (Effect)
import Effect.Aff (launchAff_)
import Effect.Class (liftEffect)
import Lipgloss as L
import Lipgloss.Charmtone as C
import Lipgloss.Layout as Layout
import Lipgloss.List (Item(..))
import Lipgloss.List as List
import Lipgloss.Painted (blankRow, paint, unpaint)
import Lipgloss.Sx (Sx(..))
import Lipgloss.Sx as Style
import Lipgloss.Table as Table
import Lipgloss.Tree (Tree(..))
import Lipgloss.Tree as Tree
import Test.Exit (exit)
import Test.Spec (Spec, describe, it)
import Test.Spec.Assertions (shouldEqual)
import Test.Spec.Reporter.Console (consoleReporter)
import Test.Spec.Runner (defaultConfig, evalSpecT)
import Test.Spec.Summary (successful)

main :: Effect Unit
main = launchAff_ do
  results <- un Identity (evalSpecT (defaultConfig { exit = false }) [ consoleReporter ] specs)
  unless (successful results) (exit 1 # liftEffect)

specs :: Spec Unit
specs = describe "Lipgloss" do
  it "draws borders and padding" do
    L.render (L.newStyle # L.border L.roundedBorder # L.padding 0 1 0 1) "hi"
      `shouldEqual` "╭────╮\n│ hi │\n╰────╯"

  it "draws a border on some sides" do
    L.render (L.newStyle # L.borderSides L.normalBorder { top: false, right: true, bottom: false, left: true }) "x"
      `shouldEqual` "│x│"

  it "builds the same style from an Sx block" do
    Style.render box "hi" `shouldEqual` "╭────╮\n│ hi │\n╰────╯"

  it "adds a property only when guarded true" do
    Style.render (selected 1) "x" `shouldEqual` Style.render (Bg C.charple) "x"
    Style.render (selected 0) "x" `shouldEqual` "x"

  it "measures text without its styles" do
    L.stringWidth (L.render (L.newStyle # L.bold true # L.foreground (L.color "#FF60FF")) "hello") `shouldEqual` 5
    L.stringHeight "a\nb\nc" `shouldEqual` 3

  it "joins blocks" do
    L.joinHorizontal L.top [ "a\nb", "c" ] `shouldEqual` "ac\nb "
    L.joinVertical L.right [ "abc", "d" ] `shouldEqual` "abc\n  d"

  it "places text in a box" do
    L.place { width: 5, height: 3 } L.center L.center "x" `shouldEqual` "     \n  x  \n     "

  it "draws text over other text" do
    L.placeOverlay { x: 1, y: 1 } "XY" "....\n....\n...." `shouldEqual` "....\n.XY.\n...."

  it "renders tables" do
    Table.render Table.defaults { headers = [ "Name", "Age" ], rows = [ [ "Ada", "36" ] ] }
      `shouldEqual` "┌────┬───┐\n│Name│Age│\n├────┼───┤\n│Ada │36 │\n└────┴───┘"

  it "renders nested lists" do
    List.render (List.list []) { items = [ Item "Fruit", Nested (List.list [ "Apple", "Pear" ]) { enumerator = List.arabic } ] }
      `shouldEqual` "• Fruit\n  1. Apple\n  2. Pear"

  it "renders trees" do
    Tree.render (Node "src" [ Leaf "Main.purs", Node "Data" [ Leaf "List.purs" ] ])
      `shouldEqual` "src\n├── Main.purs\n└── Data\n    └── List.purs"

  it "paints a header across the whole row" do
    L.stringWidth (unpaint (chrome.bold C.charple " CRUSH " <> chrome.plain C.smoke "  ~/code" <> blankRow C.bbq 20)) `shouldEqual` 35

  it "paints spans on a shared background" do
    L.stringWidth (unpaint (chrome.plain (L.color "#FFFFFF") "abc" <> blankRow (L.color "#000000") 2)) `shouldEqual` 5

  it "lays out rows that fill their box" do
    L.stringWidth (Layout.renderLayout { width: 20, height: 1 } (L.color "#000000") (Layout.row [ Layout.fixed 5 (Layout.text (chrome.raw "left")), Layout.flex 1 (Layout.text (chrome.raw "right")) ]))
      `shouldEqual` 9
  where
  selected i = Bg C.charple # Style.guard (i == 1)
  chrome = paint (L.color "#000000")
  box = Style.do
    Border L.roundedBorder Style.all
    PadX 1
