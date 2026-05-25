package lipgloss

import (
	"github.com/charmbracelet/lipgloss/v2"
	"github.com/charmbracelet/lipgloss/v2/list"
	. "github.com/purescript-native/go-runtime"
)

func init() {
	exports := Foreign("Lipgloss.List")

	exports["new"] = func() Any {
		return list.New()
	}

	exports["render"] = func(l_ Any) Any {
		return l_.(*list.List).String()
	}

	exports["itemImpl"] = func(s_, l_ Any) Any {
		return l_.(*list.List).Item(s_.(string))
	}

	exports["itemsImpl"] = func(xs_, l_ Any) Any {
		xs := xs_.([]Any)
		strs := make([]any, len(xs))
		for i, x := range xs {
			strs[i] = x.(string)
		}
		return l_.(*list.List).Items(strs...)
	}

	exports["itemListImpl"] = func(sub_, l_ Any) Any {
		return l_.(*list.List).Item(sub_.(*list.List))
	}

	exports["enumeratorImpl"] = func(e_, l_ Any) Any {
		return l_.(*list.List).Enumerator(e_.(list.Enumerator))
	}

	exports["enumeratorStyleImpl"] = func(s_, l_ Any) Any {
		return l_.(*list.List).EnumeratorStyle(s_.(lipgloss.Style))
	}

	exports["itemStyleImpl"] = func(s_, l_ Any) Any {
		return l_.(*list.List).ItemStyle(s_.(lipgloss.Style))
	}

	exports["offsetImpl"] = func(o_, l_ Any) Any {
		d := o_.(Dict)
		return l_.(*list.List).Offset(d["start"].(int), d["end"].(int))
	}

	exports["hideImpl"] = func(v_, l_ Any) Any {
		return l_.(*list.List).Hide(v_.(bool))
	}

	exports["bullet"] = list.Enumerator(list.Bullet)
	exports["asterisk"] = list.Enumerator(list.Asterisk)
	exports["dash"] = list.Enumerator(list.Dash)
	exports["arabic"] = list.Enumerator(list.Arabic)
	exports["alphabet"] = list.Enumerator(list.Alphabet)
	exports["roman"] = list.Enumerator(list.Roman)
}
