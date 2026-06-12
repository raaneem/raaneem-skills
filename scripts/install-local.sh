#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source_dir="$repo_root/skills"
dest_dir="${AGENTS_SKILLS_DIR:-$HOME/.agents/skills}"

mkdir -p "$dest_dir"

if [[ ! -d "$source_dir" ]]; then
  echo "No skills directory found: $source_dir" >&2
  exit 1
fi

installed=0
skipped=0

for skill_dir in "$source_dir"/*; do
  [[ -d "$skill_dir" ]] || continue

  skill_name="$(basename "$skill_dir")"
  skill_file="$skill_dir/SKILL.md"
  link_path="$dest_dir/$skill_name"

  if [[ ! -f "$skill_file" ]]; then
    echo "Skipping $skill_name: missing SKILL.md"
    skipped=$((skipped + 1))
    continue
  fi

  if [[ -L "$link_path" ]]; then
    current_target="$(readlink "$link_path")"
    if [[ "$current_target" == "$skill_dir" ]]; then
      echo "Already linked: $skill_name"
    else
      echo "Relinking: $skill_name"
      rm "$link_path"
      ln -s "$skill_dir" "$link_path"
    fi
  elif [[ -e "$link_path" ]]; then
    echo "Skipping $skill_name: $link_path already exists and is not a symlink" >&2
    skipped=$((skipped + 1))
    continue
  else
    echo "Linking: $skill_name"
    ln -s "$skill_dir" "$link_path"
  fi

  installed=$((installed + 1))
done

echo
echo "Installed or verified $installed skill(s) in $dest_dir."
if [[ "$skipped" -gt 0 ]]; then
  echo "Skipped $skipped item(s)."
fi
echo "Restart Codex if newly added skills do not appear."
