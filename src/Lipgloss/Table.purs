-- | Tables.
-- |
-- |     Table.render Table.defaults
-- |       { headers = [ "Language", "Formal" ]
-- |       , rows = [ [ "German", "Guten Tag" ], [ "Japanese", "こんにちは" ] ]
-- |       , border = L.roundedBorder
-- |       , style = \row _ -> if row == Table.header then bold else plain
-- |       }
module Lipgloss.Table
  ( Table
  , defaults
  , header
  , render
  ) where

import Prelude

import Lipgloss (Border, Style, newStyle, normalBorder)

type Table =
  { headers :: Array String
  , rows :: Array (Array String)
  , border :: Border
  , borderStyle :: Style
  , borders ::
      { top :: Boolean
      , bottom :: Boolean
      , left :: Boolean
      , right :: Boolean
      , header :: Boolean
      , columns :: Boolean
      , rows :: Boolean
      }
  -- | `0` fits the content.
  , width :: Int
  -- | `0` fits the content.
  , height :: Int
  -- | The first row to show.
  , offset :: Int
  , wrap :: Boolean
  -- | The style of the cell in a row and column. The headers are row `header`.
  , style :: Int -> Int -> Style
  }

defaults :: Table
defaults =
  { headers: []
  , rows: []
  , border: normalBorder
  , borderStyle: newStyle
  , borders: { top: true, bottom: true, left: true, right: true, header: true, columns: true, rows: false }
  , width: 0
  , height: 0
  , offset: 0
  , wrap: true
  , style: \_ _ -> newStyle
  }

-- | The row number of the headers, in `style`.
header :: Int
header = -1

render :: Table -> String
render table =
  renderImpl table.headers table.rows table.border table.borderStyle
    table.borders.top
    table.borders.bottom
    table.borders.left
    table.borders.right
    table.borders.header
    table.borders.columns
    table.borders.rows
    table.width
    table.height
    table.offset
    table.wrap
    table.style

foreign import renderImpl
  :: Array String
  -> Array (Array String)
  -> Border
  -> Style
  -> Boolean
  -> Boolean
  -> Boolean
  -> Boolean
  -> Boolean
  -> Boolean
  -> Boolean
  -> Int
  -> Int
  -> Int
  -> Boolean
  -> (Int -> Int -> Style)
  -> String
