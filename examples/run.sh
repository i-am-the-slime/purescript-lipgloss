#!/usr/bin/env bash
# Builds an example with Iris and runs it.
#
#   ./run.sh Showcase
#
# Environment: IRIS (the iris binary), IRIS_GO (a local iris-go checkout to build against).
set -euo pipefail
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
IRIS="${IRIS:-iris}"
EXAMPLE="${1:?which example? e.g. ./run.sh Showcase}"
OUT="$HERE/out/$EXAMPLE"
mkdir -p "$OUT"
{
  echo "module example.com/$(echo "$EXAMPLE" | tr '[:upper:]' '[:lower:]')"
  echo
  echo "go 1.27.0"
  if [ -n "${IRIS_GO:-}" ]; then
    echo
    echo "replace github.com/i-am-the-slime/iris-go => $IRIS_GO"
  fi
} >"$OUT/go.mod"
ENTRY="$EXAMPLE.main"
if [ -f "$HERE/src/$EXAMPLE/Main.purs" ]; then ENTRY="$EXAMPLE.Main.main"; fi
(cd "$HERE" && "$IRIS" go --entry "$ENTRY" "$OUT" >/dev/null)
(cd "$OUT" && go mod tidy >/dev/null 2>&1 && go build -o "$EXAMPLE" .)
shift
exec "$OUT/$EXAMPLE" "$@"
