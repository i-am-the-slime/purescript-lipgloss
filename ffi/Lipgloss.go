package lipgloss

import (
	lipgloss "github.com/charmbracelet/lipgloss"
	. "github.com/purescript-native/go-runtime"
)

func init() {
	exports := Foreign("Lipgloss")

	exports["color"] = func(color_ Any) Any {
		color := color_.(string)
		return lipgloss.Color(color)
	}

	exports["newStyle"] = func() Any {
		return lipgloss.NewStyle()
	}

	exports["renderImpl"] = func(style_ Any, text_ Any) Any {
		style := style_.(lipgloss.Style)
		text := text_.(string)
		return style.Render(text)
	}

	exports["foregroundImpl"] = func(color_ Any, style_ Any) Any {
		color := color_.(lipgloss.Color)
		style := style_.(lipgloss.Style)
		return style.Foreground(color)
	}

	exports["backgroundImpl"] = func(color_ Any, style_ Any) Any {
		color := color_.(lipgloss.Color)
		style := style_.(lipgloss.Style)
		return style.Background(color)
	}

	exports["boldImpl"] = func(yesOrNo_ Any, style_ Any) Any {
		yesOrNo := yesOrNo_.(bool)
		style := style_.(lipgloss.Style)
		return style.Bold(yesOrNo)
	}

	exports["italicImpl"] = func(yesOrNo_ Any, style_ Any) Any {
		yesOrNo := yesOrNo_.(bool)
		style := style_.(lipgloss.Style)
		return style.Italic(yesOrNo)
	}

	exports["underlineImpl"] = func(yesOrNo_ Any, style_ Any) Any {
		yesOrNo := yesOrNo_.(bool)
		style := style_.(lipgloss.Style)
		return style.Underline(yesOrNo)
	}

	exports["paddingImpl"] = func(top_ Any, right_ Any, bottom_ Any, left_ Any, style_ Any) Any {
		top := top_.(int)
		right := right_.(int)
		bottom := bottom_.(int)
		left := left_.(int)
		style := style_.(lipgloss.Style)
		return style.Padding(top, right, bottom, left)
	}

	exports["paddingTopImpl"] = func(top_ Any, style_ Any) Any {
		top := top_.(int)
		style := style_.(lipgloss.Style)
		return style.PaddingTop(top)
	}

	exports["paddingRightImpl"] = func(right_ Any, style_ Any) Any {
		right := right_.(int)
		style := style_.(lipgloss.Style)
		return style.PaddingRight(right)
	}

	exports["paddingBottomImpl"] = func(bottom_ Any, style_ Any) Any {
		bottom := bottom_.(int)
		style := style_.(lipgloss.Style)
		return style.PaddingBottom(bottom)
	}

	exports["paddingLeftImpl"] = func(left_ Any, style_ Any) Any {
		left := left_.(int)
		style := style_.(lipgloss.Style)
		return style.PaddingLeft(left)
	}

	exports["widthImpl"] = func(width_ Any, style_ Any) Any {
		width := width_.(int)
		style := style_.(lipgloss.Style)
		return style.Width(width)
	}

	exports["borderStyleImpl"] = func(borderStyle_ Any, style_ Any) Any {
		borderStyle := borderStyle_.(lipgloss.Border)
		style := style_.(lipgloss.Style)
		return style.BorderStyle(borderStyle)
	}

	exports["roundedBorder"] = lipgloss.RoundedBorder()

	exports["borderForegroundImpl"] = func(color_ Any, style_ Any) Any {
		color := color_.(lipgloss.Color)
		style := style_.(lipgloss.Style)
		return style.BorderForeground(color)
	}

	exports["centerV"] = lipgloss.Center
	exports["centerH"] = lipgloss.Center
	exports["left"] = lipgloss.Left
	exports["right"] = lipgloss.Right
	exports["top"] = lipgloss.Top
	exports["bottom"] = lipgloss.Bottom

	// lipgloss.PlaceHorizontal(80, lipgloss.Center, fancyStyledParagraph)
	exports["placeHorizontalImpl"] = func(width_ Any, alignment_ Any, text_ Any) Any {
		width := width_.(int)
		alignment := alignment_.(lipgloss.Position)
		text := text_.(string)
		return lipgloss.PlaceHorizontal(width, alignment, text)
	}

	exports["placeVerticalImpl"] = func(height_ Any, alignment_ Any, text_ Any) Any {
		height := height_.(int)
		alignment := alignment_.(lipgloss.Position)
		text := text_.(string)
		return lipgloss.PlaceVertical(height, alignment, text)
	}

}
