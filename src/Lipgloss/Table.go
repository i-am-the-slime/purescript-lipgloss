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
	width, height, offset int32,
	wrap bool,
	style func(int32) func(int32) lipgloss.Style,
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
		YOffset(int(offset)).
		Wrap(wrap).
		StyleFunc(func(row, column int) lipgloss.Style { return style(int32(row))(int32(column)) })
	if width > 0 {
		t = t.Width(int(width))
	}
	if height > 0 {
		t = t.Height(int(height))
	}
	return t.String()
}
