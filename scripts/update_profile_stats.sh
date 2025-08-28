#!/usr/bin/env 
set -euo pipefail

# .env を読み込み（あれば）
if [[ -f ".env" ]]; then
  set -a; source .env; set +a
fi

# URLと保存先のペアを列挙（'|'区切り）
PAIRS=$(
  cat <<'EOF'
__URL1__|img/profile_stats.svg
__URL2__|img/profile_languages.svg
EOF
)

# 置換（ここで .env の値を反映）
PAIRS="${PAIRS/__URL1__/${PROFILE_STATS_URL}}"
PAIRS="${PAIRS/__URL2__/${PROFILE_LANGUAGES_URL}}"

UPDATED=0

# 各ペアを順番に処理
echo "$PAIRS" | while IFS='|' read -r url dest; do
  tmp="$(mktemp)"
  echo "→ Fetch: $url"
  curl -fsSL "$url" -o "$tmp"

  # 空ファイル防止
  if [[ ! -s "$tmp" ]]; then
    echo "  ✗ empty file (skip)"; rm -f "$tmp"; continue
  fi

  # 差分があるときだけ更新
  if [[ ! -f "$dest" ]] || ! cmp -s "$tmp" "$dest"; then
    mv "$tmp" "$dest"
    echo "  ✓ updated: $dest"
    UPDATED=1
  else
    rm -f "$tmp"
    echo "  = no change: $dest"
  fi
done

if [[ $UPDATED -eq 1 ]]; then
  echo "✅ SVGs updated. Commit if needed:"
  echo "   git add img/*.svg && git commit -m 'chore: update svgs' && git push"
else
  echo "ℹ️  No changes."
fi
