-- | Faithful port of `github.com/charmbracelet/x/exp/charmtone` — the color
-- | palette used by crush, gum, and the rest of the Charm catalog. Each name
-- | maps to a hex string suitable for `Lipgloss.color`.
module Lipgloss.Charmtone where

import Lipgloss (Color, color)

-- Reds / oranges
cumin    = color "#BF976F" :: Color
tang     = color "#FF985A" :: Color
yam      = color "#FFB587" :: Color
paprika  = color "#D36C64" :: Color
bengal   = color "#FF6E63" :: Color
uni      = color "#FF937D" :: Color
sriracha = color "#EB4268" :: Color
coral    = color "#FF577D" :: Color
salmon   = color "#FF7F90" :: Color
chili    = color "#E23080" :: Color
cherry   = color "#FF388B" :: Color
tuna     = color "#FF6DAA" :: Color

-- Pinks / magentas
macaron  = color "#E940B0" :: Color
pony     = color "#FF4FBF" :: Color
cheeky   = color "#FF79D0" :: Color
flamingo = color "#F947E3" :: Color
dolly    = color "#FF60FF" :: Color
blush    = color "#FF84FF" :: Color
urchin   = color "#C337E0" :: Color
mochi    = color "#EB5DFF" :: Color
lilac    = color "#F379FF" :: Color
prince   = color "#9C35E1" :: Color
violet   = color "#C259FF" :: Color
mauve    = color "#D46EFF" :: Color
grape    = color "#7134DD" :: Color
plum     = color "#9953FF" :: Color
orchid   = color "#AD6EFF" :: Color

-- Purples / blues
jelly    = color "#4A30D9" :: Color
charple  = color "#6B50FF" :: Color
hazy     = color "#8B75FF" :: Color
ox       = color "#3331B2" :: Color
sapphire = color "#4949FF" :: Color
guppy    = color "#7272FF" :: Color
oceania  = color "#2B55B3" :: Color
thunder  = color "#4776FF" :: Color
anchovy  = color "#719AFC" :: Color
damson   = color "#007AB8" :: Color
malibu   = color "#00A4FF" :: Color
sardine  = color "#4FBEFE" :: Color

-- Teals / greens
zinc     = color "#10B1AE" :: Color
turtle   = color "#0ADCD9" :: Color
lichen   = color "#5CDFEA" :: Color
guac     = color "#12C78F" :: Color
julep    = color "#00FFB2" :: Color
bok      = color "#68FFD6" :: Color

-- Yellows
mustard  = color "#F5EF34" :: Color
citron   = color "#E8FF27" :: Color
zest     = color "#E8FE96" :: Color

-- Greyscale (dark -> light)
pepper   = color "#201F26" :: Color
bbq      = color "#2D2C35" :: Color
charcoal = color "#3A3943" :: Color
iron     = color "#4D4C57" :: Color
oyster   = color "#605F6B" :: Color
squid    = color "#858392" :: Color
smoke    = color "#BFBCC8" :: Color
ash      = color "#DFDBDD" :: Color
salt     = color "#F1EFEF" :: Color
butter   = color "#FFFAF1" :: Color

-- Diffs: additions
pickle   = color "#00A475" :: Color
gator    = color "#18463D" :: Color
spinach  = color "#1C3634" :: Color

-- Diffs: deletions
pom      = color "#AB2454" :: Color
steak    = color "#582238" :: Color
toast    = color "#412130" :: Color
