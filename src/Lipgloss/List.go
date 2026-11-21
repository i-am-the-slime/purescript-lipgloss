package ffi

import (
	"charm.land/lipgloss/v2"
	"charm.land/lipgloss/v2/list"
)

type Enumerator = list.Enumerator

type NativeList = *list.List

// Node is a list item: text, or a list nested under the item before it.
type Node struct {
	text   string
	nested *list.List
}

var (
	Bullet   list.Enumerator = list.Bullet
	Asterisk list.Enumerator = list.Asterisk
	Dash     list.Enumerator = list.Dash
	Arabic   list.Enumerator = list.Arabic
	Alphabet list.Enumerator = list.Alphabet
	Roman    list.Enumerator = list.Roman
)

func ListImpl(enumerator list.Enumerator, enumeratorStyle, itemStyle lipgloss.Style, nodes []Node) *list.List {
	l := list.New().Enumerator(enumerator).EnumeratorStyle(enumeratorStyle).ItemStyle(itemStyle)
	for _, node := range nodes {
		if node.nested != nil {
			l.Item(node.nested)
		} else {
			l.Item(node.text)
		}
	}
	return l
}

func ItemNode(text string) Node { return Node{text: text} }

func NestedNode(nested *list.List) Node { return Node{nested: nested} }

func RenderImpl(l *list.List) string { return l.String() }
