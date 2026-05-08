#!/usr/bin/env bash

set -euo pipefail

EXPECTED_BRANCH="main"
UPSTREAM_REPO="meall-tech/agents"
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ASSET_DIR="$ROOT_DIR/software/meall-agents"
VERSION_FILE="$ASSET_DIR/VERSION.txt"
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

if [[ -z "$latest_version" ]]; then
  echo "error: could not determine the latest upstream version" >&2
  exit 1
fi

update_required=1
if (( ! FORCE )) && [[ -n "$tracked_version" ]]; then
  if version_greater_than "$latest_version" "$tracked_version"; then
    update_required=1
  else
    update_required=0
  fi
fi

if (( update_required == 0 )); then
  echo "MeAll Agents is already current at $tracked_version"
  exit 0
fi

if (( CHECK_ONLY )); then
  if [[ -n "$tracked_version" ]]; then
    echo "Update available: $tracked_version -> $latest_version"
  else
    echo "Update available: no tracked version -> $latest_version"
  fi
  exit 0
fi

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
