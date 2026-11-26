package ffi

import (
	"charm.land/lipgloss/v2"
	"charm.land/lipgloss/v2/table"
)

func RenderImpl(
	headers []string,
	rows [][]string,
	border lipgloss.Border,
	borderStyle lipgloss.Style,
	top, bottom, left, right, header, columns, rowLines bool,
	width, height, offset int,
	wrap bool,
	style func(int) func(int) lipgloss.Style,
) string {
	t := table.New().
		Headers(headers...).
		Rows(rows...).
		Border(border).
		BorderStyle(borderStyle).
		BorderTop(top).
		BorderBottom(bottom).
		BorderLeft(left).
		BorderRight(right).
		BorderHeader(header).
		BorderColumn(columns).
		BorderRow(rowLines).
		YOffset(offset).
		Wrap(wrap).
		StyleFunc(func(row, column int) lipgloss.Style { return style(row)(column) })
	if width > 0 {
		t = t.Width(width)
	}
	if height > 0 {
		t = t.Height(height)
	}
	return t.String()
}
