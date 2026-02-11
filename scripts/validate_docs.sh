#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

echo "==> mkdocs build --strict"
mkdocs build --strict >/dev/null

echo "==> Проверка на склейку markdown-заголовков"
if rg -n '\)## (Источники|Стандарты и источники|Кросс-ссылки)' docs >/dev/null; then
  echo "Найдены склеенные заголовки вида ')## ...' в markdown-файлах." >&2
  rg -n '\)## (Источники|Стандарты и источники|Кросс-ссылки)' docs >&2
  exit 1
fi

echo "==> Проверка пройдена"
