package lipgloss

import (
	"image/color"

	"github.com/charmbracelet/lipgloss/v2"
	"github.com/charmbracelet/lipgloss/v2/table"
	. "github.com/purescript-native/go-runtime"
)

func init() {
	exports := Foreign("Lipgloss.Table")

	exports["new"] = func() Any {
		return table.New()
	}

	exports["render"] = func(t_ Any) Any {
		return t_.(*table.Table).Render()
	}

	exports["rowsImpl"] = func(rows_, t_ Any) Any {
		rowsArr := rows_.([]Any)
		rows := make([][]string, len(rowsArr))
		for i, r := range rowsArr {
			cells := r.([]Any)
			row := make([]string, len(cells))
			for j, c := range cells {
				row[j] = c.(string)
			}
			rows[i] = row
		}
		return t_.(*table.Table).Rows(rows...)
	}

	exports["rowImpl"] = func(cells_, t_ Any) Any {
		cellsArr := cells_.([]Any)
		cells := make([]string, len(cellsArr))
		for i, c := range cellsArr {
			cells[i] = c.(string)
		}
		return t_.(*table.Table).Row(cells...)
	}

	exports["headersImpl"] = func(hs_, t_ Any) Any {
		hsArr := hs_.([]Any)
		hs := make([]string, len(hsArr))
		for i, h := range hsArr {
			hs[i] = h.(string)
		}
		return t_.(*table.Table).Headers(hs...)
	}

	exports["dataImpl"] = func(d_, t_ Any) Any {
		return t_.(*table.Table).Data(d_.(table.Data))
	}

	exports["borderImpl"] = func(b_, t_ Any) Any {
		return t_.(*table.Table).Border(b_.(lipgloss.Border))
	}

	exports["borderStyleImpl"] = func(s_, t_ Any) Any {
		return t_.(*table.Table).BorderStyle(s_.(lipgloss.Style))
	}

	exports["borderTopImpl"] = func(v_, t_ Any) Any {
		return t_.(*table.Table).BorderTop(v_.(bool))
	}
	exports["borderBottomImpl"] = func(v_, t_ Any) Any {
		return t_.(*table.Table).BorderBottom(v_.(bool))
	}
	exports["borderLeftImpl"] = func(v_, t_ Any) Any {
		return t_.(*table.Table).BorderLeft(v_.(bool))
	}
	exports["borderRightImpl"] = func(v_, t_ Any) Any {
		return t_.(*table.Table).BorderRight(v_.(bool))
	}
	exports["borderHeaderImpl"] = func(v_, t_ Any) Any {
		return t_.(*table.Table).BorderHeader(v_.(bool))
	}
	exports["borderColumnImpl"] = func(v_, t_ Any) Any {
		return t_.(*table.Table).BorderColumn(v_.(bool))
	}
	exports["borderRowImpl"] = func(v_, t_ Any) Any {
		return t_.(*table.Table).BorderRow(v_.(bool))
	}

	exports["borderForegroundImpl"] = func(c_, t_ Any) Any {
		s := lipgloss.NewStyle().Foreground(c_.(color.Color))
		return t_.(*table.Table).BorderStyle(s)
	}

	exports["widthImpl"] = func(w_, t_ Any) Any {
		return t_.(*table.Table).Width(w_.(int))
	}
	exports["heightImpl"] = func(h_, t_ Any) Any {
		return t_.(*table.Table).Height(h_.(int))
	}
	exports["offsetImpl"] = func(o_, t_ Any) Any {
		return t_.(*table.Table).Offset(o_.(int))
	}
	exports["wrapImpl"] = func(w_, t_ Any) Any {
		return t_.(*table.Table).Wrap(w_.(bool))
	}

	exports["styleFuncImpl"] = func(fn_, t_ Any) Any {
		fn := fn_.(func(Any) Any)
		return t_.(*table.Table).StyleFunc(func(row, col int) lipgloss.Style {
			result := fn(Dict{"row": row, "col": col})
			if s, ok := result.(lipgloss.Style); ok {
				return s
			}
			return lipgloss.NewStyle()
		})
	}
}
