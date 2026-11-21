-- | Faithful port of `github.com/charmbracelet/x/exp/charmtone` — the color
-- | palette used by crush, gum, and the rest of the Charm catalog. Each name
-- | maps to a hex string suitable for `Lipgloss.color`.
module Lipgloss.Charmtone where

import Lipgloss (Color, Hex(..), color)

-- Reds / oranges
cumin    = color (Hex "#BF976F") :: Color
tang     = color (Hex "#FF985A") :: Color
yam      = color (Hex "#FFB587") :: Color
paprika  = color (Hex "#D36C64") :: Color
bengal   = color (Hex "#FF6E63") :: Color
uni      = color (Hex "#FF937D") :: Color
sriracha = color (Hex "#EB4268") :: Color
coral    = color (Hex "#FF577D") :: Color
salmon   = color (Hex "#FF7F90") :: Color
chili    = color (Hex "#E23080") :: Color
cherry   = color (Hex "#FF388B") :: Color
tuna     = color (Hex "#FF6DAA") :: Color

-- Pinks / magentas
macaron  = color (Hex "#E940B0") :: Color
pony     = color (Hex "#FF4FBF") :: Color
cheeky   = color (Hex "#FF79D0") :: Color
flamingo = color (Hex "#F947E3") :: Color
dolly    = color (Hex "#FF60FF") :: Color
blush    = color (Hex "#FF84FF") :: Color
urchin   = color (Hex "#C337E0") :: Color
mochi    = color (Hex "#EB5DFF") :: Color
lilac    = color (Hex "#F379FF") :: Color
prince   = color (Hex "#9C35E1") :: Color
violet   = color (Hex "#C259FF") :: Color
mauve    = color (Hex "#D46EFF") :: Color
grape    = color (Hex "#7134DD") :: Color
plum     = color (Hex "#9953FF") :: Color
orchid   = color (Hex "#AD6EFF") :: Color

-- Purples / blues
jelly    = color (Hex "#4A30D9") :: Color
charple  = color (Hex "#6B50FF") :: Color
hazy     = color (Hex "#8B75FF") :: Color
ox       = color (Hex "#3331B2") :: Color
sapphire = color (Hex "#4949FF") :: Color
guppy    = color (Hex "#7272FF") :: Color
oceania  = color (Hex "#2B55B3") :: Color
thunder  = color (Hex "#4776FF") :: Color
anchovy  = color (Hex "#719AFC") :: Color
damson   = color (Hex "#007AB8") :: Color
malibu   = color (Hex "#00A4FF") :: Color
sardine  = color (Hex "#4FBEFE") :: Color

-- Teals / greens
zinc     = color (Hex "#10B1AE") :: Color
turtle   = color (Hex "#0ADCD9") :: Color
lichen   = color (Hex "#5CDFEA") :: Color
guac     = color (Hex "#12C78F") :: Color
julep    = color (Hex "#00FFB2") :: Color
bok      = color (Hex "#68FFD6") :: Color

-- Yellows
mustard  = color (Hex "#F5EF34") :: Color
citron   = color (Hex "#E8FF27") :: Color
zest     = color (Hex "#E8FE96") :: Color

-- Greyscale (dark -> light)
pepper   = color (Hex "#201F26") :: Color
bbq      = color (Hex "#2D2C35") :: Color
charcoal = color (Hex "#3A3943") :: Color
iron     = color (Hex "#4D4C57") :: Color
oyster   = color (Hex "#605F6B") :: Color
squid    = color (Hex "#858392") :: Color
smoke    = color (Hex "#BFBCC8") :: Color
ash      = color (Hex "#DFDBDD") :: Color
salt     = color (Hex "#F1EFEF") :: Color
butter   = color (Hex "#FFFAF1") :: Color

-- Diffs: additions
pickle   = color (Hex "#00A475") :: Color
gator    = color (Hex "#18463D") :: Color
spinach  = color (Hex "#1C3634") :: Color

-- Diffs: deletions
pom      = color (Hex "#AB2454") :: Color
steak    = color (Hex "#582238") :: Color
toast    = color (Hex "#412130") :: Color
