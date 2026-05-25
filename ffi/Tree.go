package lipgloss

import (
	"github.com/charmbracelet/lipgloss/v2"
	"github.com/charmbracelet/lipgloss/v2/tree"
	. "github.com/purescript-native/go-runtime"
)

func init() {
	exports := Foreign("Lipgloss.Tree")

	exports["new"] = func() Any {
		return tree.New()
	}

	exports["render"] = func(t_ Any) Any {
		return t_.(*tree.Tree).String()
	}

	exports["rootImpl"] = func(s_, t_ Any) Any {
		return t_.(*tree.Tree).Root(s_.(string))
	}

	exports["childImpl"] = func(xs_, t_ Any) Any {
		xs := xs_.([]Any)
		kids := make([]any, len(xs))
		for i, x := range xs {
			kids[i] = x.(string)
		}
		return t_.(*tree.Tree).Child(kids...)
	}

	exports["childTreeImpl"] = func(sub_, t_ Any) Any {
		return t_.(*tree.Tree).Child(sub_.(*tree.Tree))
	}

	exports["enumeratorImpl"] = func(e_, t_ Any) Any {
		return t_.(*tree.Tree).Enumerator(e_.(tree.Enumerator))
	}

	exports["enumeratorStyleImpl"] = func(s_, t_ Any) Any {
		return t_.(*tree.Tree).EnumeratorStyle(s_.(lipgloss.Style))
	}

	exports["rootStyleImpl"] = func(s_, t_ Any) Any {
		return t_.(*tree.Tree).RootStyle(s_.(lipgloss.Style))
	}

	exports["itemStyleImpl"] = func(s_, t_ Any) Any {
		return t_.(*tree.Tree).ItemStyle(s_.(lipgloss.Style))
	}

	exports["offsetImpl"] = func(o_, t_ Any) Any {
		d := o_.(Dict)
		return t_.(*tree.Tree).Offset(d["start"].(int), d["end"].(int))
	}

	exports["hideImpl"] = func(v_, t_ Any) Any {
		return t_.(*tree.Tree).Hide(v_.(bool))
	}

	exports["defaultEnumerator"] = tree.Enumerator(tree.DefaultEnumerator)
	exports["roundedEnumerator"] = tree.Enumerator(tree.RoundedEnumerator)
}
