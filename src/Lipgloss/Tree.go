package ffi

import (
	"charm.land/lipgloss/v2"
	"charm.land/lipgloss/v2/tree"
)

type Enumerator = tree.Enumerator

type NativeTree = *tree.Tree

type Child struct {
	text    string
	subtree *tree.Tree
}

var (
	DefaultEnumerator tree.Enumerator = tree.DefaultEnumerator
	RoundedEnumerator tree.Enumerator = tree.RoundedEnumerator
)

func TreeImpl(enumerator tree.Enumerator, enumeratorStyle, rootStyle, itemStyle lipgloss.Style, root string, children []Child) *tree.Tree {
	t := tree.Root(root).Enumerator(enumerator).EnumeratorStyle(enumeratorStyle).RootStyle(rootStyle).ItemStyle(itemStyle)
	for _, child := range children {
		if child.subtree != nil {
			t.Child(child.subtree)
		} else {
			t.Child(child.text)
		}
	}
	return t
}

func LeafNode(text string) Child { return Child{text: text} }

func SubtreeNode(subtree *tree.Tree) Child { return Child{subtree: subtree} }

func RenderImpl(t *tree.Tree) string { return t.String() }
