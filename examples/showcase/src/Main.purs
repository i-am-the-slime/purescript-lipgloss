module Main where

import Prelude

import Effect (Effect)
import Effect.Console (log)
import Lipgloss as L

main :: Effect Unit
main = do
  base <- L.newStyle
  let
    pink = L.color (Hex "#ff5fff")
    cyan = L.color (Hex "#5fd7d7")
    grey = L.color (Hex "240")
    adaptive = L.adaptiveColor { light: "#222", dark: "#eee" }
    complete = L.completeColor { trueColor: "#ff5fff", ansi256: "207", ansi: "5" }

    decorations = base
      # L.foreground pink
      # L.background grey
      # L.bold true
      # L.italic true
      # L.underline true
      # L.strikethrough true
      # L.faint false
      # L.reverseVideo false
      # L.blink false
      # L.inline true
      # L.padding 0 2 0 2
    decoratedDemo = L.render decorations "decorations"

    paddedBox = base
      # L.foreground cyan
      # L.padding 1 4 1 4
      # L.margin 0 2 0 0
      # L.borderStyle L.roundedBorder
      # L.borderForeground pink
      # L.borderBackground grey
    paddedDemo = L.render paddedBox "padded + margin + rounded"

    sidedBorder = base
      # L.border L.thickBorder
          { top: true, right: false, bottom: true, left: false }
      # L.foreground adaptive
      # L.paddingTop 1
      # L.paddingBottom 1
      # L.paddingLeft 2
      # L.paddingRight 2
    sidedDemo = L.render sidedBorder "thick top+bottom only"

    sizedBox = base
      # L.width 24
      # L.height 3
      # L.maxWidth 24
      # L.maxHeight 3
      # L.align L.center L.center
      # L.alignHorizontal L.center
      # L.alignVertical L.center
      # L.borderStyle L.doubleBorder
      # L.foreground complete
    sizedDemo = L.render sizedBox "fixed-size"

    perSide = base
      # L.borderStyle L.normalBorder
      # L.borderTop true
      # L.borderRight false
      # L.borderBottom true
      # L.borderLeft false
      # L.marginTop 0
      # L.marginRight 0
      # L.marginBottom 0
      # L.marginLeft 0
    perSideDemo = L.render perSide "per-side borders"

    blockBorderDemo = L.render (base # L.borderStyle L.blockBorder # L.padding 0 1 0 1) "blockBorder"
    hiddenBorderDemo = L.render (base # L.borderStyle L.hiddenBorder # L.padding 0 1 0 1) "hiddenBorder"
    noColorDemo = L.render (base # L.foreground L.noColor) "noColor foreground"

    -- placement helpers
    centeredH = L.placeHorizontal 40 L.center "centered horizontally"
    centeredV = L.placeVertical 3 L.center "centered vertically"
    placed = L.place 40 3 L.center L.center "place(40x3,center,center)"

    -- legacy aliases still work
    legacyCentered = L.placeHorizontal 40 L.centerH "centerH legacy alias"
    legacyVertical = L.placeVertical 3 L.centerV "centerV legacy alias"

    -- joins
    cols =
      [ L.render (base # L.borderStyle L.roundedBorder # L.padding 0 1 0 1 # L.foreground pink) "col A"
      , L.render (base # L.borderStyle L.roundedBorder # L.padding 0 1 0 1 # L.foreground cyan) "col B"
      , L.render (base # L.borderStyle L.roundedBorder # L.padding 0 1 0 1 # L.foreground adaptive) "col C"
      ]
    joinedH = L.joinHorizontal L.top cols
    joinedV = L.joinVertical L.left
      [ L.render (base # L.bold true # L.foreground pink) "line 1"
      , L.render (base # L.italic true # L.foreground cyan) "line 2"
      , L.render (base # L.underline true) "line 3"
      ]

    measurement = "width " <> show (L.stringWidth joinedH)
      <> ", height " <> show (L.stringHeight joinedV)

  log "── decorations ──────────────────────────────────────────"
  log decoratedDemo
  log ""
  log "── padded + margin + rounded ────────────────────────────"
  log paddedDemo
  log ""
  log "── thick border, top + bottom only ──────────────────────"
  log sidedDemo
  log ""
  log "── fixed-size box (24x3) with align center/center ───────"
  log sizedDemo
  log ""
  log "── per-side borders (top + bottom, normal) ──────────────"
  log perSideDemo
  log ""
  log "── block + hidden borders, noColor foreground ───────────"
  log blockBorderDemo
  log hiddenBorderDemo
  log noColorDemo
  log ""
  log "── placement ─────────────────────────────────────────────"
  log centeredH
  log centeredV
  log placed
  log ""
  log "── legacy aliases ────────────────────────────────────────"
  log legacyCentered
  log legacyVertical
  log ""
  log "── joinHorizontal ───────────────────────────────────────"
  log joinedH
  log ""
  log "── joinVertical ─────────────────────────────────────────"
  log joinedV
  log ""
  log measurement
