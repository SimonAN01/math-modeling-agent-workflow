#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST="${1:-${AGENT_SKILLS_DIR:-$HOME/.local/share/agent-skills}}"
BACKUP="$DEST/.mathmodel-backups/$(date +%Y%m%d-%H%M%S)-$$"

mkdir -p "$DEST" "$BACKUP"
for source in "$ROOT"/skills/*; do
  name="$(basename "$source")"
  if [ -e "$DEST/$name" ] || [ -L "$DEST/$name" ]; then
    mv "$DEST/$name" "$BACKUP/$name"
  fi
  cp -a "$source" "$DEST/$name"
  printf 'installed %s\n' "$name"
done
printf 'Backups (if any): %s\n' "$BACKUP"
