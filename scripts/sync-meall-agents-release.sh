#!/usr/bin/env bash

set -euo pipefail

EXPECTED_BRANCH="main"
UPSTREAM_REPO="meall-tech/agents"
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ASSET_DIR="$ROOT_DIR/software/meall-agents"
VERSION_FILE="$ASSET_DIR/VERSION.txt"
CHANGELOG_FILE="$ASSET_DIR/CHANGELOG.md"
COMMIT_TRAILER="Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>"

FORCE=0
CHECK_ONLY=0
DO_PULL=0
DO_COMMIT=0
DO_PUSH=0

usage() {
  cat <<'EOF'
Usage: ./scripts/sync-meall-agents-release.sh [options]

Sync the public MeAll Agents binaries in this repository from the latest
GitHub release in meall-tech/agents.

Options:
  --check-only  Report whether an update is needed without modifying files
  --force       Download and replace assets even if VERSION.txt matches
  --pull        Fast-forward from origin/main before syncing
  --commit      Create a git commit when files change
  --push        Push the commit to origin/main (implies --commit)
  -h, --help    Show this help text
EOF
}

normalize_version() {
  local version="${1:-}"
  version="${version#"${version%%[![:space:]]*}"}"
  version="${version%"${version##*[![:space:]]}"}"
  printf '%s' "${version#v}"
}

version_greater_than() {
  python3 - "$1" "$2" <<'PY'
import re
import sys

def tokenize(value: str):
    value = value.strip()
    if value.startswith("v"):
        value = value[1:]
    tokens = []
    for part in re.split(r"[.+-]", value):
        if part == "":
            continue
        if part.isdigit():
            tokens.append((0, int(part)))
        else:
            tokens.append((1, part))
    return tokens

left = tokenize(sys.argv[1])
right = tokenize(sys.argv[2])
sys.exit(0 if left > right else 1)
PY
}

format_release_date() {
  python3 - "$1" <<'PY'
from datetime import datetime
import sys

value = sys.argv[1].strip()
if not value:
    raise SystemExit("error: missing published release date")

dt = datetime.fromisoformat(value.replace("Z", "+00:00"))
print(f"{dt.strftime('%B')} {dt.day}, {dt.year}")
PY
}

extract_release_summary() {
  local body
  body="$(cat)"

  RELEASE_BODY="$body" python3 - <<'PY'
import os
import re

body = os.environ["RELEASE_BODY"].replace("\r\n", "\n")
lines = body.split("\n")

h1_index = next((i for i, line in enumerate(lines) if re.match(r"^#\s+\S", line)), None)
if h1_index is None:
    raise SystemExit("error: release body is missing a first H1 heading")

hr_re = re.compile(r"^\s{0,3}([-*_])(?:\s*\1){2,}\s*$")
hr_index = next((i for i in range(h1_index + 1, len(lines)) if hr_re.match(lines[i])), None)
if hr_index is None:
    raise SystemExit("error: release body is missing a horizontal rule after the summary block")

block = lines[h1_index + 1:hr_index]
while block and not block[0].strip():
    block.pop(0)
while block and not block[-1].strip():
    block.pop()

if block and re.match(r"^\*\*Release Date:\*\*", block[0].strip()):
    block.pop(0)
    while block and not block[0].strip():
        block.pop(0)

summary = "\n".join(block).strip()
if not summary:
    raise SystemExit("error: release body summary block is empty")

print(summary)
PY
}

changelog_contains_entry() {
  local summary
  summary="$(cat)"

  CHANGELOG_SUMMARY="$summary" python3 - "$1" "$2" "$3" <<'PY'
import os
from pathlib import Path
import sys

path, version, release_date = sys.argv[1:4]
summary = os.environ["CHANGELOG_SUMMARY"].strip()
expected = f"## {version} — {release_date}\n\n{summary}\n"

try:
    contents = Path(path).read_text()
except FileNotFoundError:
    raise SystemExit(1)

raise SystemExit(0 if expected in contents.replace("\r\n", "\n") else 1)
PY
}

update_changelog() {
  local summary
  summary="$(cat)"

  CHANGELOG_SUMMARY="$summary" python3 - "$1" "$2" "$3" <<'PY'
import os
from pathlib import Path
import re
import sys

path, version, release_date = sys.argv[1:4]
summary = os.environ["CHANGELOG_SUMMARY"].strip()
entry = f"## {version} — {release_date}\n\n{summary}\n"

file_path = Path(path)
try:
    existing = file_path.read_text().replace("\r\n", "\n")
except FileNotFoundError:
    existing = ""

pattern = re.compile(rf"(?ms)^##\s+{re.escape(version)}\s+—.*?(?:\n---\n|\Z)")
remaining = pattern.sub("", existing).lstrip("\n")

if remaining:
    new_contents = entry.rstrip() + "\n\n---\n" + remaining
else:
    new_contents = entry

file_path.write_text(new_contents)
PY
}

require_main_branch() {
  local branch
  branch="$(git -C "$ROOT_DIR" branch --show-current)"
  if [[ "$branch" != "$EXPECTED_BRANCH" ]]; then
    echo "error: expected branch '$EXPECTED_BRANCH' but found '$branch'" >&2
    exit 1
  fi
}

ensure_clean_worktree() {
  if [[ -n "$(git -C "$ROOT_DIR" status --porcelain)" ]]; then
    echo "error: working tree must be clean for this operation" >&2
    exit 1
  fi
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --check-only)
      CHECK_ONLY=1
      ;;
    --force)
      FORCE=1
      ;;
    --pull)
      DO_PULL=1
      ;;
    --commit)
      DO_COMMIT=1
      ;;
    --push)
      DO_COMMIT=1
      DO_PUSH=1
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "error: unknown option '$1'" >&2
      usage >&2
      exit 1
      ;;
  esac
  shift
done

require_main_branch

if [[ ! -d "$ASSET_DIR" ]]; then
  echo "error: asset directory not found: $ASSET_DIR" >&2
  exit 1
fi

if (( DO_PULL )); then
  ensure_clean_worktree
  git -C "$ROOT_DIR" pull --ff-only origin "$EXPECTED_BRANCH"
fi

tracked_version=""
if [[ -f "$VERSION_FILE" ]]; then
  tracked_version="$(normalize_version "$(cat "$VERSION_FILE")")"
fi

latest_tag="$(GH_PAGER=cat gh release view --repo "$UPSTREAM_REPO" --json tagName --jq '.tagName')"
latest_version="$(normalize_version "$latest_tag")"
release_published_at="$(GH_PAGER=cat gh release view "$latest_tag" --repo "$UPSTREAM_REPO" --json publishedAt --jq '.publishedAt')"
release_body="$(GH_PAGER=cat gh release view "$latest_tag" --repo "$UPSTREAM_REPO" --json body --jq '.body')"
release_date="$(format_release_date "$release_published_at")"
release_summary="$(extract_release_summary <<<"$release_body")"

if [[ -z "$latest_version" ]]; then
  echo "error: could not determine the latest upstream version" >&2
  exit 1
fi

asset_update_required=1
if (( ! FORCE )) && [[ -n "$tracked_version" ]]; then
  if version_greater_than "$latest_version" "$tracked_version"; then
    asset_update_required=1
  else
    asset_update_required=0
  fi
fi

changelog_update_required=1
if changelog_contains_entry "$CHANGELOG_FILE" "$latest_version" "$release_date" <<<"$release_summary"; then
  changelog_update_required=0
fi

if (( asset_update_required == 0 )) && (( changelog_update_required == 0 )); then
  echo "MeAll Agents is already current at $tracked_version"
  exit 0
fi

if (( CHECK_ONLY )); then
  if (( asset_update_required )); then
    if [[ -n "$tracked_version" ]]; then
      echo "Update available: $tracked_version -> $latest_version"
    else
      echo "Update available: no tracked version -> $latest_version"
    fi
  fi
  if (( changelog_update_required )); then
    echo "Changelog update needed for $latest_version"
  fi
  if (( asset_update_required == 0 )) && (( changelog_update_required == 0 )); then
    echo "Update available: $tracked_version -> $latest_version"
  fi
  exit 0
fi

if (( asset_update_required )); then
  tmp_dir="$(mktemp -d "${TMPDIR:-/tmp}/meall-agents-sync.XXXXXX")"
  trap 'rm -rf "$tmp_dir"' EXIT

  asset_pairs=(
    "MeAll.Agents.Setup.${latest_version}.exe:MeAllAgents-Setup-x64.exe"
    "MeAll.Agents-${latest_version}.dmg:MeAllAgents-x64.dmg"
    "MeAll.Agents-${latest_version}-arm64.dmg:MeAllAgents-arm64.dmg"
    "MeAll.Agents-${latest_version}.AppImage:MeAllAgents-x86.AppImage"
  )

  download_args=(release download "$latest_tag" --repo "$UPSTREAM_REPO" --dir "$tmp_dir")
  for asset_pair in "${asset_pairs[@]}"; do
    upstream_name="${asset_pair%%:*}"
    download_args+=(--pattern "$upstream_name")
  done

  GH_PAGER=cat gh "${download_args[@]}"

  for asset_pair in "${asset_pairs[@]}"; do
    upstream_name="${asset_pair%%:*}"
    dest_name="${asset_pair#*:}"
    local_path="$tmp_dir/$upstream_name"
    dest_path="$ASSET_DIR/$dest_name"
    if [[ ! -f "$local_path" ]]; then
      echo "error: expected downloaded asset not found: $upstream_name" >&2
      exit 1
    fi
    rm -f "$dest_path"
    mv "$local_path" "$dest_path"
  done

  printf '%s\n' "$latest_version" > "$VERSION_FILE"
fi

if (( changelog_update_required )); then
  update_changelog "$CHANGELOG_FILE" "$latest_version" "$release_date" <<<"$release_summary"
fi

echo "Synced MeAll Agents assets to $latest_version"

if (( DO_COMMIT )); then
  if [[ -z "$(git -C "$ROOT_DIR" status --porcelain -- "$ASSET_DIR")" ]]; then
    echo "No repository changes were produced"
    exit 0
  fi
  git -C "$ROOT_DIR" add "$ASSET_DIR"
  git -C "$ROOT_DIR" commit -m "Update MeAll Agents binaries to $latest_version" -m "$COMMIT_TRAILER"
fi

if (( DO_PUSH )); then
  git -C "$ROOT_DIR" push origin "$EXPECTED_BRANCH"
fi
