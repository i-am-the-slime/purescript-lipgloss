package lipgloss

import (
	"image/color"
	"strings"

	"github.com/charmbracelet/lipgloss/v2"
	"github.com/charmbracelet/x/ansi"
	. "github.com/purescript-native/go-runtime"
)

func init() {
	exports := Foreign("Lipgloss")

	exports["colorImpl"] = func(s_ Any) Any {
		return lipgloss.Color(s_.(string))
	}

	exports["adaptiveColorImpl"] = func(light_, dark_ Any) Any {
		return lipgloss.LightDark(false)(lipgloss.Color(light_.(string)), lipgloss.Color(dark_.(string)))
	}

	exports["completeColorImpl"] = func(trueColor_, _, _ Any) Any {
		// lipgloss v2 dropped CompleteColor: the colorprofile dependency now
		// downsamples automatically. Honor the TrueColor entry and trust
		// terminal detection for the fallbacks.
		return lipgloss.Color(trueColor_.(string))
	}

	exports["noColor"] = color.Transparent

	exports["newStyle"] = lipgloss.NewStyle()

	exports["renderImpl"] = func(style_, text_ Any) Any {
		return style_.(lipgloss.Style).Render(text_.(string))
	}

	exports["stringWidth"] = func(s_ Any) Any {
		return lipgloss.Width(s_.(string))
	}

	exports["placeOverlayImpl"] = func(x_, y_, overlay_, base_ Any) Any {
		x := x_.(int)
		y := y_.(int)
		overlay := overlay_.(string)
		base := base_.(string)
		baseLines := strings.Split(base, "\n")
		overlayLines := strings.Split(overlay, "\n")
		overlayW := lipgloss.Width(overlay)
		for i, oline := range overlayLines {
			row := y + i
			if row < 0 || row >= len(baseLines) {
				continue
			}
			bline := baseLines[row]
			left := ansi.Truncate(bline, x, "")
			leftW := lipgloss.Width(left)
			if leftW < x {
				left += strings.Repeat(" ", x-leftW)
			}
			right := ansi.TruncateLeft(bline, x+overlayW, "")
			baseLines[row] = left + oline + right
		}
		return strings.Join(baseLines, "\n")
	}

	exports["stringHeight"] = func(s_ Any) Any {
		return lipgloss.Height(s_.(string))
	}

	exports["foregroundImpl"] = func(c_, s_ Any) Any {
		return s_.(lipgloss.Style).Foreground(c_.(color.Color))
	}
	exports["backgroundImpl"] = func(c_, s_ Any) Any {
		return s_.(lipgloss.Style).Background(c_.(color.Color))
	}
	exports["boldImpl"] = func(b_, s_ Any) Any {
		return s_.(lipgloss.Style).Bold(b_.(bool))
	}
	exports["italicImpl"] = func(b_, s_ Any) Any {
		return s_.(lipgloss.Style).Italic(b_.(bool))
	}
	exports["underlineImpl"] = func(b_, s_ Any) Any {
		return s_.(lipgloss.Style).Underline(b_.(bool))
	}
	exports["strikethroughImpl"] = func(b_, s_ Any) Any {
		return s_.(lipgloss.Style).Strikethrough(b_.(bool))
	}
	exports["faintImpl"] = func(b_, s_ Any) Any {
		return s_.(lipgloss.Style).Faint(b_.(bool))
	}
	exports["reverseImpl"] = func(b_, s_ Any) Any {
		return s_.(lipgloss.Style).Reverse(b_.(bool))
	}
	exports["blinkImpl"] = func(b_, s_ Any) Any {
		return s_.(lipgloss.Style).Blink(b_.(bool))
	}
	exports["inlineImpl"] = func(b_, s_ Any) Any {
		return s_.(lipgloss.Style).Inline(b_.(bool))
	}

	exports["paddingImpl"] = func(t_, r_, b_, l_, s_ Any) Any {
		return s_.(lipgloss.Style).Padding(t_.(int), r_.(int), b_.(int), l_.(int))
	}
	exports["paddingTopImpl"] = func(n_, s_ Any) Any {
		return s_.(lipgloss.Style).PaddingTop(n_.(int))
	}
	exports["paddingRightImpl"] = func(n_, s_ Any) Any {
		return s_.(lipgloss.Style).PaddingRight(n_.(int))
	}
	exports["paddingBottomImpl"] = func(n_, s_ Any) Any {
		return s_.(lipgloss.Style).PaddingBottom(n_.(int))
	}
	exports["paddingLeftImpl"] = func(n_, s_ Any) Any {
		return s_.(lipgloss.Style).PaddingLeft(n_.(int))
	}

	exports["marginImpl"] = func(t_, r_, b_, l_, s_ Any) Any {
		return s_.(lipgloss.Style).Margin(t_.(int), r_.(int), b_.(int), l_.(int))
	}
	exports["marginTopImpl"] = func(n_, s_ Any) Any {
		return s_.(lipgloss.Style).MarginTop(n_.(int))
	}
	exports["marginRightImpl"] = func(n_, s_ Any) Any {
		return s_.(lipgloss.Style).MarginRight(n_.(int))
	}
	exports["marginBottomImpl"] = func(n_, s_ Any) Any {
		return s_.(lipgloss.Style).MarginBottom(n_.(int))
	}
	exports["marginLeftImpl"] = func(n_, s_ Any) Any {
		return s_.(lipgloss.Style).MarginLeft(n_.(int))
	}

	exports["widthImpl"] = func(n_, s_ Any) Any {
		return s_.(lipgloss.Style).Width(n_.(int))
	}
	exports["heightImpl"] = func(n_, s_ Any) Any {
		return s_.(lipgloss.Style).Height(n_.(int))
	}
	exports["maxWidthImpl"] = func(n_, s_ Any) Any {
		return s_.(lipgloss.Style).MaxWidth(n_.(int))
	}
	exports["maxHeightImpl"] = func(n_, s_ Any) Any {
		return s_.(lipgloss.Style).MaxHeight(n_.(int))
	}

	exports["top"] = lipgloss.Top
	exports["bottom"] = lipgloss.Bottom
	exports["left"] = lipgloss.Left
	exports["right"] = lipgloss.Right
	exports["center"] = lipgloss.Center

	exports["alignImpl"] = func(h_, v_, s_ Any) Any {
		return s_.(lipgloss.Style).Align(h_.(lipgloss.Position), v_.(lipgloss.Position))
	}
	exports["alignHorizontalImpl"] = func(p_, s_ Any) Any {
		return s_.(lipgloss.Style).AlignHorizontal(p_.(lipgloss.Position))
	}
	exports["alignVerticalImpl"] = func(p_, s_ Any) Any {
		return s_.(lipgloss.Style).AlignVertical(p_.(lipgloss.Position))
	}

	exports["normalBorder"] = lipgloss.NormalBorder()
	exports["roundedBorder"] = lipgloss.RoundedBorder()
	exports["thickBorder"] = lipgloss.ThickBorder()
	exports["doubleBorder"] = lipgloss.DoubleBorder()
	exports["blockBorder"] = lipgloss.BlockBorder()
	exports["hiddenBorder"] = lipgloss.HiddenBorder()

	exports["borderStyleImpl"] = func(b_, s_ Any) Any {
		return s_.(lipgloss.Style).BorderStyle(b_.(lipgloss.Border))
	}
	exports["borderImpl"] = func(b_, top_, right_, bottom_, left_, s_ Any) Any {
		return s_.(lipgloss.Style).Border(b_.(lipgloss.Border), top_.(bool), right_.(bool), bottom_.(bool), left_.(bool))
	}
	exports["borderForegroundImpl"] = func(c_, s_ Any) Any {
		return s_.(lipgloss.Style).BorderForeground(c_.(color.Color))
	}
	exports["borderBackgroundImpl"] = func(c_, s_ Any) Any {
		return s_.(lipgloss.Style).BorderBackground(c_.(color.Color))
	}
	exports["borderTopImpl"] = func(b_, s_ Any) Any {
		return s_.(lipgloss.Style).BorderTop(b_.(bool))
	}
	exports["borderRightImpl"] = func(b_, s_ Any) Any {
		return s_.(lipgloss.Style).BorderRight(b_.(bool))
	}
	exports["borderBottomImpl"] = func(b_, s_ Any) Any {
		return s_.(lipgloss.Style).BorderBottom(b_.(bool))
	}
	exports["borderLeftImpl"] = func(b_, s_ Any) Any {
		return s_.(lipgloss.Style).BorderLeft(b_.(bool))
	}

	exports["placeImpl"] = func(w_, h_, hp_, vp_, str_ Any) Any {
		return lipgloss.Place(w_.(int), h_.(int), hp_.(lipgloss.Position), vp_.(lipgloss.Position), str_.(string))
	}
	exports["placeHorizontalImpl"] = func(w_, p_, str_ Any) Any {
		return lipgloss.PlaceHorizontal(w_.(int), p_.(lipgloss.Position), str_.(string))
	}
	exports["placeVerticalImpl"] = func(h_, p_, str_ Any) Any {
		return lipgloss.PlaceVertical(h_.(int), p_.(lipgloss.Position), str_.(string))
	}

	exports["joinHorizontalImpl"] = func(p_, cols_ Any) Any {
		cols := cols_.([]Any)
		strs := make([]string, len(cols))
		for i, c := range cols {
			strs[i] = c.(string)
		}
		return lipgloss.JoinHorizontal(p_.(lipgloss.Position), strs...)
	}
	exports["joinVerticalImpl"] = func(p_, rows_ Any) Any {
		rows := rows_.([]Any)
		strs := make([]string, len(rows))
		for i, r := range rows {
			strs[i] = r.(string)
		}
		return lipgloss.JoinVertical(p_.(lipgloss.Position), strs...)
	}
}
